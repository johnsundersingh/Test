//********************************************************************
// 
//  file:  DioWebProcessor.cs
// 
//  (C) Copyright 2010, Diomede Corporation
//  All rights reserved
// 
//  Use, modification, and distribution is subject to   
//  the New BSD License (See accompanying file license.txt).
// 
//********************************************************************

using System;
using System.Collections.Generic;
using System.Text;
using darrenjohnstone.net.FileUpload.DioTransfer;
using System.IO;

namespace darrenjohnstone.net.FileUpload
{
    /// <summary>
    /// Implements the IFileProcessor interface to provide a processor for streaming uploads into a Diomde Storage account.
    /// </summary>
    [Serializable()]
    public class DioWebProcessor : IFileProcessor
    {
        #region Declarations

        [NonSerialized()]
        DiomedeStorageTransferClient _transferProxy;

        [NonSerialized()]
        string _fileName;

        [NonSerialized()]
        string _fullFileName;

        [NonSerialized()]
        bool _errorState;

        [NonSerialized()]
        Dictionary<string, string> _headerItems;

        string _sessionToken;

        #endregion

        #region Properties

        /// <summary>
        /// Gets/sets the session token.
        /// </summary>
        public string SessionToken
        {
            get { return _sessionToken; }
            set { _sessionToken = value; }
        }

        #endregion

        #region Constructor

        /// <summary>
        /// Constructor.
        /// </summary>
        public DioWebProcessor()
        {
            _fullFileName = string.Empty;
            _sessionToken = string.Empty;
        }

        #endregion

        #region IFileProcessor Members

        long _newFileID;
        long _offset;
        
        public object StartNewFile(string fileName, string contentType, Dictionary<string, string> headerItems, Dictionary<string, string> previousFields)
        {
            // Initialize values
            _errorState = false;
            _headerItems = headerItems;
            _fileName = Path.GetFileName(fileName);
            _fullFileName = fileName;

            _offset = 0;

            try
            {
                // Instantiate transfer client
                _transferProxy = new DiomedeStorageTransferClient();
                
                // Create file
                _newFileID = _transferProxy.CreateFile(_sessionToken, _fileName, string.Empty, string.Empty);
            }
            catch (Exception ex)
            {
                _errorState = true;
                throw ex;
            }

            return null;
        }

        public void Write(byte[] buffer, int offset, int count)
        {
            if (_errorState) return;

            try
            {
                // Create a stream with the chunk of data only
                MemoryStream memstream = new MemoryStream(buffer, offset, count);

                // Add chunk specific info
                UploadInfo fileInfo = new UploadInfo()
                {
                    bufferLength = count,
                    fileID = _newFileID,
                    isComplete = false,
                    offset = _offset
                };

                // Transfer chunk to diomede account
                _transferProxy.Upload(_sessionToken, fileInfo, memstream);

                // Add count of bytes copied
                _offset += count;
            }
            catch (Exception ex)
            {
                _errorState = true;
                throw ex;
            }
        }

        public void EndFile()
        {
            if (_errorState) return;

            if (_transferProxy != null)
            {
                try
                {
                    // Create a chunk info object only to set the file as completed
                    UploadInfo fileInfo = new UploadInfo()
                    {
                        bufferLength = 0,
                        fileID = _newFileID,
                        isComplete = true,
                        offset = 0
                    };

                    // Transfer the file chunk info
                    _transferProxy.Upload(_sessionToken, fileInfo, new MemoryStream());
                    
                    // Set the proxy as closed 
                    _transferProxy.Close();
                }
                catch (Exception ex)
                {
                    _errorState = true;
                    throw ex;
                }
            }
        }

        public string GetFileName()
        {
            return _fileName;
        }

        public virtual object GetIdentifier()
        {
            return _newFileID;
        }

        public Dictionary<string, string> GetHeaderItems()
        {
            return _headerItems;
        }

        #endregion

        #region IDisposable Members

        public void Dispose()
        {
            if (_transferProxy != null)
            {
                _transferProxy = null;
            }
        }

        #endregion
    }
}

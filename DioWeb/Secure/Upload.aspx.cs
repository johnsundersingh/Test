//********************************************************************
// 
//  file:  Upload.aspx.cs
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
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using DioWeb.DioTransfer;
using DioWeb.App_Classes;
using DioWeb.DioService;
using System.ServiceModel;
using darrenjohnstone.net.FileUpload;
using System.Text;

namespace DioWeb.Secure
{
    public partial class Upload : DioWeb.App_Classes.DioBasePage
    {
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            this.ProcessUploadResult();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Set DioWeb processor
            DioWebProcessor dwp = new DioWebProcessor();
            dwp.SessionToken = base.SessionToken;
            DJUploadController.DefaultFileProcessor = dwp;
        }

        private void CreateFileMetadata(long fileID, string fileFullName)
        {
            try
            {
                string dir = Path.GetDirectoryName(fileFullName);

                if (string.IsNullOrEmpty(dir))
                {
                    throw new Exception(string.Format("Default file metadata was not created. File name {0}. File directory path: {1}", fileFullName, dir));
                }

                // Create file full path metadata object
                using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                {

                    // Get matching metadata objects from service
                    List<MetaData> listMetaData = svcProxy.GetMetaData(base.SessionToken, null, CommonConstants.DEFAULT_METADATA_OBJECT_SFP, dir);

                    // Find a matching metadata value (full source directory)
                    MetaData metaData = listMetaData.Find(m => m.value.Equals(dir));

                    if (metaData == null)
                    {
                        // If no matching metadata was found, create a new one
                        svcProxy.CreateFileMetaData(base.SessionToken, fileID, CommonConstants.DEFAULT_METADATA_OBJECT_SFP, dir);
                    }
                    else
                    {
                        // Otherwise we set the existing metadata to the new file
                        svcProxy.SetFileMetaData(base.SessionToken, fileID, metaData.metaDataID);
                    }
                }
            }
            catch (Exception ex)
            {
                HandleException(ex);
            }
        }

        private void ProcessUploadResult()
        {
            if (Page.IsPostBack && DJUploadController.Status != null)
            {
                StringBuilder sb = new StringBuilder();

                if (DJUploadController.Status.LengthExceeded)
                {
                    sb.Append("<h4 style='color:#FF0000'>The maximum upload size was exceeded.</h4>");
                }

                if (!UploadManager.Instance.ModuleInstalled)
                {
                    sb.Append("<h4 style='color:#FF0000'>Uploads were not processed via the module.</h4>");
                }

                if (DJUploadController.Status.UploadedFiles.Count > 0)
                {
                    sb.Append("<div class='message success'>");
                    sb.Append("<strong>Files successfully uploaded</strong><br />");
                    sb.Append("<table style='width:100%;'>");

                    sb.Append("<tr style='color:#FFF;background-color:#009600;height: 24px;'>");
                    sb.Append("<th>FileName</th>");
                    sb.Append("<th>FileID</th>");
                    sb.Append("</tr>");

                    foreach (UploadedFile f in DJUploadController.Status.UploadedFiles)
                    {
                        sb.Append("<tr>");

                        sb.Append("<td align='left'>");
                        sb.Append(f.FileName);
                        sb.Append("</td>");

                        sb.Append("<td>");
                        if (f.Identifier != null)
                        {
                            sb.Append(f.Identifier.ToString());
                        }
                        sb.Append("</td>");

                        sb.Append("</tr>");

                        //this.CreateFileMetadata((long)f.Identifier, f.FileName);
                    }

                    sb.Append("</table>");
                    sb.Append("</div>");
                }

                if (DJUploadController.Status.ErrorFiles.Count > 0)
                {
                    sb.Append("<div class='message error'>");
                    sb.Append("<strong>Files uploaded with errors</strong><br />");
                    sb.Append("<table style='width:100%;'>");

                    sb.Append("<tr style='color:#FFF;background-color:#960000;height: 24px;'>");
                    sb.Append("<th>FileName</th>");
                    sb.Append("<th>FileID</th>");
                    sb.Append("<th>Exception</th>");
                    sb.Append("</tr>");

                    foreach (UploadedFile f in DJUploadController.Status.ErrorFiles)
                    {
                        sb.Append("<tr>");

                        sb.Append("<td align='left'>");
                        sb.Append(f.FileName);
                        sb.Append("</td>");

                        sb.Append("<td>");
                        if ((long)f.Identifier > 0)
                        {
                            sb.Append(f.Identifier.ToString());
                            //this.CreateFileMetadata((long)f.Identifier, f.FileName);
                        }
                        sb.Append("</td>");

                        sb.Append("<td align='left'>");
                        if (f.Exception != null)
                        {
                            sb.Append(f.Exception.Message);
                        }
                        sb.Append("</td>");

                        sb.Append("</tr>");
                    }

                    sb.Append("</table>");
                    sb.Append("</div>");
                }

                litResults.Text = sb.ToString();
            }
        }
    }
}
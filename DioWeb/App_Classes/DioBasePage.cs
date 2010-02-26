//********************************************************************
// 
//  file:  DioBasePage.cs
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
using System.ComponentModel;
using DioWeb.DioService;
using System.ServiceModel;
using System.Web.Security;

namespace DioWeb.App_Classes
{
    public class DioBasePage : System.Web.UI.Page
    {
        #region SSL
        [Browsable(true)]
        [Description("Indicates whether or not this page should be forced into or out of SSL")]
        public virtual bool RequireSSL { get; set; }

        [System.Diagnostics.DebuggerStepThrough()]
        [System.Diagnostics.Conditional("RELEASE")]
        private void PushSSL()
        {
            //Force required into secure channel
            if (RequireSSL && Request.IsSecureConnection == false)
            {
                UriBuilder ub = new UriBuilder(Request.Url);
                ub.Scheme = Uri.UriSchemeHttps;
                ub.Port = -1; // use default value for protocol
                Response.Redirect(ub.ToString());
            }

            //Force non-required out of secure channel
            if (!RequireSSL && Request.IsSecureConnection == true)
            {
                UriBuilder ub = new UriBuilder(Request.Url);
                ub.Scheme = Uri.UriSchemeHttp;
                ub.Port = -1; // use default value for protocol
                Response.Redirect(ub.ToString());
            }
        }
        #endregion

        #region Session
        private string _sessionToken;
        public string SessionToken
        {
            get
            {
                System.Web.Security.FormsIdentity fid = HttpContext.Current.User.Identity as System.Web.Security.FormsIdentity;
                if (fid != null)
                {
                    _sessionToken = fid.Ticket.UserData;
                }
                return _sessionToken;
            }
        }
        #endregion

        #region StorageTypes
        private List<StorageType> storageTypes;
        public void SetStorageTypes()
        {
            try
            {
                using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                {
                    storageTypes = svcProxy.GetStorageTypes();
                }
            }
            catch (FaultException ex)
            {
                this.HandleException(ex);
            }
        }
        public List<StorageType> GetStorageTypes()
        {
            if (this.storageTypes == null)
            {
                this.SetStorageTypes();
            }
            return this.storageTypes;
        }
        protected string GetStorageTypeName(int storageTypeID)
        {
            string retVal = "<em>none</em>";
            if (this.storageTypes != null)
            {
                retVal = storageTypes.Single(st => st.storageTypeID == storageTypeID).name;
            }
            return retVal;
        }
        #endregion

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            PushSSL();
        }

        #region exception handling
        protected bool HandleException(Exception exception)
        {
            bool retVal = false;
            if (exception != null)
            {
                Exception ex = exception.GetBaseException();
                if (ex is FaultException)
                {
                    if (ex.Message.Equals(CommonConstants.EXCEPTION_SESSION_EXPIRED))
                    {
                        LogoutAndRedirectToLogin(CommonConstants.LOGIN_MESSAGE_SESSION_EXPIRED_VALUE);
                    }
                    else if (ex.Message.Equals(CommonConstants.EXCEPTION_INVALID_SESSION))
                    {
                        LogoutAndRedirectToLogin(CommonConstants.LOGIN_MESSAGE_INVALID_SESSION);
                    }
                }
                ((MasterPages.Common)this.Page.Master).ShowMessage(ex.Message, MessageTypes.Error);
                retVal = true;
            }
            return retVal;
        }

        public static void LogoutAndRedirectToLogin(string value)
        {
            FormsAuthentication.SignOut();
            HttpContext.Current.ClearError();
            FormsAuthentication.RedirectToLoginPage(string.Format("{0}={1}", DioWeb.App_Classes.CommonConstants.LOGIN_MESSAGE_KEY, value));
        }
        #endregion
    }

    public class ServiceExceptionEventArgs : System.EventArgs
    {
        private Exception _exception;
        public Exception Exception
        {
            get
            {
                return _exception;
            }
        }

        public ServiceExceptionEventArgs(Exception ex)
        {
            this._exception = ex;
        }
    }
}

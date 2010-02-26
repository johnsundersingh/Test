//********************************************************************
// 
//  file:  Login.aspx.cs
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
using DioWeb.DioService;
using System.Web.Security;
using DioWeb.App_Classes;
using System.ServiceModel;

namespace DioWeb.Public
{
    public partial class Login : DioWeb.App_Classes.DioBasePage
    {
        string sessionToken = string.Empty;

        protected override void OnInit(EventArgs e)
        {
            base.RequireSSL = true;
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            DisplayAnyMessage();
            HideLogin();
            ctrlLogin.Focus();
        }

        private void DisplayAnyMessage()
        {
            if (!string.IsNullOrEmpty(Request.QueryString[CommonConstants.LOGIN_MESSAGE_KEY]))
            {
                switch (Request.QueryString[CommonConstants.LOGIN_MESSAGE_KEY].ToLower())
                {
                    case CommonConstants.LOGIN_MESSAGE_SESSION_EXPIRED_VALUE:
                        ((MasterPages.Common)this.Master).ShowMessage("Current session has expired, please log in again.", MessageTypes.Error);
                        break;
                    case CommonConstants.LOGIN_MESSAGE_INVALID_SESSION:
                        ((MasterPages.Common)this.Master).ShowMessage("Current session is invalid, please log in again.", MessageTypes.Error);
                        break;
                    case CommonConstants.LOGIN_MESSAGE_USER_CREATED_VALUE:
                        ((MasterPages.Common)this.Master).ShowMessage("Account successfully created!.", MessageTypes.Success);
                        if (Session[CommonConstants.SESSION_USERNAME_KEY] != null)
                        {
                            ctrlLogin.UserName = Session[CommonConstants.SESSION_USERNAME_KEY].ToString();
                            Session.Remove(CommonConstants.SESSION_USERNAME_KEY);
                        }
                        break;
                    case CommonConstants.LOGIN_MESSAGE_USER_DELETED_VALUE:
                        ((MasterPages.Common)this.Master).ShowMessage("Account has been deleted.", MessageTypes.Success);
                        break;
                    case CommonConstants.LOGIN_MESSAGE_FORGOT_PASSWORD_VALUE:
                        ((MasterPages.Common)this.Master).ShowMessage("A new password request has been sent to your primary email account.", MessageTypes.Success);
                        break;
                }
            }
        }

        private void HideLogin()
        {
            LoginView lvControlPanel = this.Master.FindControl("lvControlPanel") as LoginView;
            HyperLink lnkLogin = lvControlPanel.FindControl("lnkLogin") as HyperLink;
            if (lnkLogin != null)
            {
                lnkLogin.Visible = false;
                lnkLogin.Enabled = false;
            }
        }

        protected void ctrlLogin_Authenticate(object sender, AuthenticateEventArgs e)
        {
            try
            {
                using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                {
                    sessionToken = svcProxy.Login(ctrlLogin.UserName, ctrlLogin.Password);
                }
                if (!sessionToken.Equals(string.Empty))
                {
                    // set the user as authenticated in DioWeb
                    e.Authenticated = true;
                }
            }
            catch (FaultException ex)
            {
                ((MasterPages.Common)this.Master).ShowMessage(ex.Message, MessageTypes.Error);

                if (ex.Message.ToLower().Contains("password"))
                {
                    ((TextBox)ctrlLogin.FindControl("Password")).Focus();
                }
                else
                {
                    if (ex.Message.ToLower().Contains("user"))
                    {
                        ((TextBox)ctrlLogin.FindControl("UserName")).Focus();
                    }
                }
            }
        }

        protected void ctrlLogin_LoggedIn(object sender, EventArgs e)
        {
            // Create the cookie that contains the forms authentication ticket
            HttpCookie authCookie = FormsAuthentication.GetAuthCookie(ctrlLogin.UserName, ctrlLogin.RememberMeSet);

            // Get the FormsAuthenticationTicket out of the encrypted cookie
            FormsAuthenticationTicket oldTicket = FormsAuthentication.Decrypt(authCookie.Value);

            // Create a new FormsAuthenticationTicket that includes Diomede session token
            FormsAuthenticationTicket newTicket = new FormsAuthenticationTicket(
                oldTicket.Version,
                oldTicket.Name,
                oldTicket.IssueDate,
                oldTicket.Expiration,
                oldTicket.IsPersistent,
                sessionToken,
                oldTicket.CookiePath
                );

            // Update the authCookie's Value to use the encrypted version of newTicket
            authCookie.Value = FormsAuthentication.Encrypt(newTicket);

            // Manually add the authCookie to the Cookies collection
            Response.Cookies.Add(authCookie);
        }
    }
}



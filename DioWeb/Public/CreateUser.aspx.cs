//********************************************************************
// 
//  file:  CreateUser.aspx.cs
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
    public partial class CreateUser : DioWeb.App_Classes.DioBasePage
    {
        protected override void OnInit(EventArgs e)
        {
            base.RequireSSL = true;
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            HideCreateUser();
            wzdCreateUser.Focus();
        }

        private void HideCreateUser()
        {
            LoginView lvControlPanel = this.Master.FindControl("lvControlPanel") as LoginView;
            HyperLink lnkCreateUser = lvControlPanel.FindControl("lnkCreateUser") as HyperLink;
            if (lnkCreateUser != null)
            {
                lnkCreateUser.Visible = false;
                lnkCreateUser.Enabled = false;
            }
        }

        protected void btnCreateUser_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                    {
                        svcProxy.CreateUser(UserName.Text, Password.Text, Email.Text);
                        Session.Add(CommonConstants.SESSION_USERNAME_KEY, UserName.Text);
                        Response.Redirect(string.Format("{0}?{1}={2}", FormsAuthentication.DefaultUrl, DioWeb.App_Classes.CommonConstants.LOGIN_MESSAGE_KEY, DioWeb.App_Classes.CommonConstants.LOGIN_MESSAGE_USER_CREATED_VALUE));
                    }
                }
                catch (FaultException ex)
                {
                    ((MasterPages.Common)this.Master).ShowMessage(ex.Message, MessageTypes.Error);

                    string message = ex.Message.ToLower();

                    if (message.Contains("email") || message.Contains("e-mail"))
                        Email.Focus();
                    else if (message.Contains("password"))
                        Password.Focus();
                    else if (message.Contains("username"))
                        UserName.Focus();
                }
            }
        }

        protected void ckbAgreementReq_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = (ckbAgreement.Checked);
        }
    }
}

//********************************************************************
// 
//  file:  ResetPassword.aspx.cs
// 
//  (C) Copyright 2010, Diomede Corporation
//  All rights reserved
// 
//  Use, modification, and distribution is subject to   
//  the New BSD License (See accompanying file license.txt).
// 
//********************************************************************

using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using DioWeb.DioService;
using DioWeb.App_Classes;
using System.ServiceModel;

namespace DioWeb.Public
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Form.DefaultFocus = txtUserName.ClientID;
            this.Form.DefaultButton = btnResetPassword.UniqueID;
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                    {
                        svcProxy.ResetPassword(txtUserName.Text);
                        Response.Redirect(string.Format("{0}?{1}={2}", FormsAuthentication.DefaultUrl, DioWeb.App_Classes.CommonConstants.LOGIN_MESSAGE_KEY, DioWeb.App_Classes.CommonConstants.LOGIN_MESSAGE_FORGOT_PASSWORD_VALUE));
                    }
                }
                catch (FaultException ex)
                {
                    ((MasterPages.Common)this.Master).ShowMessage(ex.Message, MessageTypes.Error);
                }
            }
        }
    }
}

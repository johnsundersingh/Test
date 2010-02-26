//********************************************************************
// 
//  file:  Home.aspx.cs
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
using DioWeb.App_Classes;

namespace DioWeb.Secure
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            InitializeUI();
        }

        private void InitializeUI()
        {
            if (!string.IsNullOrEmpty(Request.QueryString[CommonConstants.LOGIN_MESSAGE_KEY]) &&
                Request.QueryString[CommonConstants.LOGIN_MESSAGE_KEY].ToLower().Equals(CommonConstants.LOGIN_MESSAGE_USER_CREATED_VALUE))
            {
                litGreeting.Text = string.Format("Welcome <strong>{0}</strong> to Diomede Storage!", User.Identity.Name);
                rblAccount.Items.FindByValue(bool.FalseString.ToLower()).Text = "No thanks, I’d like to test first";
            }
            else
            {
                litGreeting.Text = string.Format("Welcome back {0}!", User.Identity.Name);
            }
            rblAccount.Focus();
        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
            if (rblAccount.SelectedValue.Equals(bool.TrueString.ToLower()))
            {
                Response.Redirect("~/Secure/Billing.aspx");
            }
            else
            {
                Response.Redirect("~/Secure/Search.aspx");
            }
        }
    }
}

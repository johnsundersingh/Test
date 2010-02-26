//********************************************************************
// 
//  file:  Settings.aspx.cs
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
    public partial class Settings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                InitializeUI();
            }
        }

        private void InitializeUI()
        {
            string pageSize = CookieHelper.GetValue(CommonConstants.COOKIE_SETTINGS_PREFIX + Context.User.Identity.Name,
                                                                 CommonConstants.COOKIE_SETTINGS_PAGESIZE_KEY);
            if (!string.IsNullOrEmpty(pageSize))
            {
                txtPageSize.Text = pageSize;
            }
            else
            {
                txtPageSize.Text = CommonConstants.DEFAULT_PAGE_SIZE.ToString();
            }

            string offset = CookieHelper.GetValue(CommonConstants.COOKIE_SETTINGS_PREFIX + Context.User.Identity.Name,
                                                               CommonConstants.COOKIE_SETTINGS_OFFSET_KEY);
            if (!string.IsNullOrEmpty(offset))
            {
                txtOffset.Text = offset;
            }
            else
            {
                txtOffset.Text = CommonConstants.DEFAULT_OFFSET.ToString();
            }
        }

        protected void btnSaveSettings_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                CookieHelper.SetValue(CommonConstants.COOKIE_SETTINGS_PREFIX + Context.User.Identity.Name, CommonConstants.COOKIE_SETTINGS_PAGESIZE_KEY, txtPageSize.Text);
                CookieHelper.SetValue(CommonConstants.COOKIE_SETTINGS_PREFIX + Context.User.Identity.Name, CommonConstants.COOKIE_SETTINGS_OFFSET_KEY, txtOffset.Text);

                ((MasterPages.Common)this.Master).ShowMessage("Settings saved.", MessageTypes.Success);
            }
        }
    }
}

//********************************************************************
// 
//  file:  Download.aspx.cs
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
using System.ServiceModel;

namespace DioWeb.Secure
{
    public partial class Download : DioWeb.App_Classes.DioBasePage
    {
        public String QueryStringFileId
        {
            get
            {
                return Request.QueryString["fid"] as String;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            GetDownloadURL();
        }

        private void GetDownloadURL()
        {
            if (!string.IsNullOrEmpty(this.QueryStringFileId))
            {
                try
                {
                    long fileId = long.Parse(this.QueryStringFileId);

                    using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                    {
                        string url = svcProxy.GetDownloadURL(base.SessionToken, fileId, null, null, null, "");
                        Response.Redirect(url);
                    }
                }
                catch (FaultException ex)
                {
                    base.HandleException(ex);
                }
            }
            else
            {
                Response.Redirect("~/Secure/Search.aspx");
            }
        }
    }
}

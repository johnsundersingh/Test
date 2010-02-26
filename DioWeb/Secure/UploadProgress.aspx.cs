//********************************************************************
// 
//  file:  UploadProgress.aspx.cs
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
using darrenjohnstone.net.FileUpload;

namespace DioWeb.Secure
{
    public partial class UploadProgress : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            Response.AppendHeader("Cache-Control", "no-cache");
            Response.AppendHeader("Cache-Control", "private");
            Response.AppendHeader("Cache-Control", "no-store");
            Response.AppendHeader("Cache-Control", "must-revalidate");
            Response.AppendHeader("Cache-Control", "max-stale=0");
            Response.AppendHeader("Cache-Control", "post-check=0");
            Response.AppendHeader("Cache-Control", "pre-check=0");
            Response.AppendHeader("Pragma", "no-cache");
            Response.AppendHeader("Keep-Alive", "timeout=3, max=993");
            Response.AppendHeader("Expires", "Mon, 26 Jul 1997 05:00:00 GMT");
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected override void OnPreRender(EventArgs e)
        {
            UploadStatus status;

            base.OnPreRender(e);

            status = UploadManager.Instance.Status;

            if (status != null)
            {
                upProgressBar.Width = new Unit(status.ProgressPercent, UnitType.Percentage);

                if (status.ProgressPercent > 0)
                {
                    lblStatus.Text = "Now uploading: <strong>" + status.CurrentFile + "</strong> (" + status.ProgressPercent.ToString() + "%) - " + status.BytesSoFar.ToString() + "/" + status.TotalSize.ToString();
                }
                else
                {
                    lblStatus.Text = "Initializing upload...";
                }
            }
            else
            {
                lblStatus.Text = "Initializing upload...";
            }
        }
    }
}

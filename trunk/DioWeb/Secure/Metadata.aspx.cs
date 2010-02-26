//********************************************************************
// 
//  file:  Metadata.aspx.cs
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
using DioWeb.App_Classes;
using DioWeb.DioService;
using System.ServiceModel;
using System.Collections.Generic;

namespace DioWeb.Secure
{
    public partial class Metadata : DioWeb.App_Classes.DioBasePage
    {
        public long FileID
        {
            get { return (long)ViewState["fid"]; }
            set { ViewState["fid"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                GetFileIDFromQueryString();
            }
        }

        private void GetFileIDFromQueryString()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["fid"]))
            {
                this.FileID = long.Parse(Request.QueryString["fid"]);
            }
            else
            {
                Response.Redirect("~/Secure/Search.aspx");
            }
        }


        protected void odsMetadata_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
        }

        protected void odsMetadata_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected void odsMetadata_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
        }

        protected void odsMetadata_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected void odsMetadata_Deleting(object sender, ObjectDataSourceMethodEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
        }

        protected void odsMetadata_Deleted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }

            lvFileMetadata.DataBind();
        }

        protected void odsMetadata_Updating(object sender, ObjectDataSourceMethodEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
        }

        protected void odsMetadata_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }

            lvFileMetadata.DataBind();
        }

        protected void lvMetadata_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (String.Equals(e.CommandName, "SetToFile"))
            {
                ListViewDataItem currentItem = (ListViewDataItem)e.Item;
                int metadataID = (int)lvMetadata.DataKeys[currentItem.DisplayIndex].Value;

                try
                {
                    using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                    {
                        svcProxy.SetFileMetaData(base.SessionToken, this.FileID, metadataID);
                    }
                }
                catch (FaultException ex)
                {
                    base.HandleException(ex);
                }
                finally
                {
                    lvMetadata.DataBind();
                    lvFileMetadata.DataBind();
                }
            }
        }

        protected void lvMetadata_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                ListViewDataItem currentItem = (ListViewDataItem)e.Item;
                //MetaData md = (MetaData)currentItem.DataItem;

                //  If editing set focus on textbox and set default button
                if (currentItem.DisplayIndex == lvMetadata.EditIndex)
                {
                    currentItem.FindControl("txtName").Focus();
                    this.Form.DefaultButton = currentItem.FindControl("btnUpdate").UniqueID;
                }
            }
        }


        protected void odsFileMetadata_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
            e.InputParameters["fileID"] = this.FileID;
        }

        protected void odsFileMetadata_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected void odsFileMetadata_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
            e.InputParameters["fileID"] = this.FileID;
        }

        protected void odsFileMetadata_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }

            lvMetadata.DataBind();
        }

        protected void odsFileMetadata_Deleting(object sender, ObjectDataSourceMethodEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
            e.InputParameters["fileID"] = this.FileID;
        }

        protected void odsFileMetadata_Deleted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }

            lvMetadata.DataBind();
        }
    }
}

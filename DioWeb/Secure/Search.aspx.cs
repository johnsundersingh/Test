//********************************************************************
// 
//  file:  Search.aspx.cs
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
using DioWeb.App_Classes;
using System.Text;
using System.ServiceModel;

namespace DioWeb.Secure
{
    public partial class Search : DioWeb.App_Classes.DioBasePage
    {
        private long? fileID = null;
        private string fileName = string.Empty;
        private string hashMD5 = string.Empty;
        private string hashSHA1 = string.Empty;
        private long? minSize = null;
        private long? maxSize = null;
        private DateTime? startDate = null;
        private DateTime? endDate = null;
        private bool? isDeleted = false;
        private bool? isComplete = null;
        private string metaName = string.Empty;
        private string metaValue = string.Empty;
        private long offset;
        private long pageSize;
        private long totalResults = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                InitializeUI();
            }
        }

        private void InitializeUI()
        {
            string pageSizeUI = CookieHelper.GetValue(CommonConstants.COOKIE_SETTINGS_PREFIX + Context.User.Identity.Name, CommonConstants.COOKIE_SETTINGS_PAGESIZEUI_KEY);
            if (!string.IsNullOrEmpty(pageSizeUI))
            {
                ddlSearchResultPageSize.Items.FindByValue(pageSizeUI).Selected = true;
            }
            else
            {
                pageSizeUI = ddlSearchResultPageSize.SelectedValue;
            }
            dpSearchFilesResult.PageSize = int.Parse(pageSizeUI);

            txtFileName.Focus();
        }

        private void SetSearchData()
        {
            string url = Request.AppRelativeCurrentExecutionFilePath + "?";

            if (!string.IsNullOrEmpty(txtFileName.Text))
            {
                url += "fileName=" + Server.UrlEncode(txtFileName.Text) + "&";
            }
            if (!string.IsNullOrEmpty(txtFileID.Text))
            {
                url += "fileID=" + Server.UrlEncode(txtFileID.Text) + "&";
            }
            if (!string.IsNullOrEmpty(txtHashMD5.Text))
            {
                url += "hashMD5=" + Server.UrlEncode(txtHashMD5.Text) + "&";
            }
            if (!string.IsNullOrEmpty(txtHashSHA1.Text))
            {
                url += "hashSHA1=" + Server.UrlEncode(txtHashSHA1.Text) + "&";
            }
            if (!string.IsNullOrEmpty(txtMinSize.Text))
            {
                url += "minSize=" + Server.UrlEncode(txtMinSize.Text) + "&";
            }
            if (!string.IsNullOrEmpty(txtMaxSize.Text))
            {
                url += "maxSize=" + Server.UrlEncode(txtMaxSize.Text) + "&";
            }
            if (!string.IsNullOrEmpty(txtStartDate.Text))
            {
                url += "startDate=" + Server.UrlDecode(txtStartDate.Text) + "&";
            }
            if (!string.IsNullOrEmpty(txtEndDate.Text))
            {
                url += "endDate=" + Server.UrlDecode(txtEndDate.Text) + "&";
            }
            if (!string.IsNullOrEmpty(txtMetaName.Text))
            {
                url += "metaName=" + Server.UrlEncode(txtMetaName.Text) + "&";
            }
            if (!string.IsNullOrEmpty(txtMetaValue.Text))
            {
                url += "metaValue=" + Server.UrlEncode(txtMetaValue.Text) + "&";
            }
            if (rblIsDeleted.SelectedIndex != -1)
            {
                url += "isDeleted=" + rblIsDeleted.SelectedValue + "&";
            }
            if (rblIsComplete.SelectedIndex != -1)
            {
                url += "isComplete=" + rblIsComplete.SelectedValue + "&";
            }

            url = url.TrimEnd('&');
            url = url.TrimEnd('?');

            Response.Redirect(url);
        }

        private void GetSearchData()
        {
            this.pageSize = CommonConstants.DEFAULT_PAGE_SIZE;
            this.offset = CommonConstants.DEFAULT_OFFSET;

            string ps = CookieHelper.GetValue(CommonConstants.COOKIE_SETTINGS_PREFIX + Context.User.Identity.Name, CommonConstants.COOKIE_SETTINGS_PAGESIZE_KEY);
            string os = CookieHelper.GetValue(CommonConstants.COOKIE_SETTINGS_PREFIX + Context.User.Identity.Name, CommonConstants.COOKIE_SETTINGS_OFFSET_KEY);

            if (!string.IsNullOrEmpty(ps))
            {
                this.pageSize = long.Parse(ps);
            }
            if (!string.IsNullOrEmpty(os))
            {
                this.offset = long.Parse(os);
            }

            if (Request.QueryString["fileID"] != null)
            {
                this.fileID = long.Parse(Request.QueryString["fileID"]);
                txtFileID.Text = this.fileID.ToString();
            }
            if (Request.QueryString["fileName"] != null)
            {
                this.fileName = Request.QueryString["fileName"];
                txtFileName.Text = this.fileName;
            }
            if (Request.QueryString["hashMD5"] != null)
            {
                this.hashMD5 = Request.QueryString["hashMD5"];
                txtHashMD5.Text = this.hashMD5;
            }
            if (Request.QueryString["hashSHA1"] != null)
            {
                this.hashSHA1 = Request.QueryString["hashSHA1"];
                txtHashSHA1.Text = this.hashSHA1;
            }
            if (Request.QueryString["minSize"] != null)
            {
                this.minSize = long.Parse(Request.QueryString["minSize"]);
                txtMinSize.Text = this.minSize.ToString();
            }
            if (Request.QueryString["maxSize"] != null)
            {
                this.maxSize = long.Parse(Request.QueryString["maxSize"]);
                txtMaxSize.Text = this.maxSize.ToString();
            }
            if (Request.QueryString["startDate"] != null)
            {
                this.startDate = DateTime.Parse(Request.QueryString["startDate"]);
                txtStartDate.Text = this.startDate.Value.ToShortDateString();
            }
            if (Request.QueryString["endDate"] != null)
            {
                this.endDate = DateTime.Parse(Request.QueryString["endDate"]);
                txtEndDate.Text = this.endDate.Value.ToShortDateString();
            }
            if (Request.QueryString["metaName"] != null)
            {
                this.metaName = Request.QueryString["metaName"];
                txtMetaName.Text = this.metaName;
            }
            if (Request.QueryString["metaValue"] != null)
            {
                this.metaValue = Request.QueryString["metaValue"];
                txtMetaValue.Text = this.metaValue;
            }
            if (Request.QueryString["isDeleted"] != null)
            {
                switch (Request.QueryString["isDeleted"].ToLower())
                {
                    case "true":
                        this.isDeleted = true; break;
                    case "false":
                        this.isDeleted = false; break;
                    default:
                        this.isDeleted = null; break;
                }

                if (this.isDeleted == null)
                {
                    rblIsDeleted.SelectedValue = "null";
                }
                else
                {
                    rblIsDeleted.SelectedValue = this.isDeleted.ToString().ToLower();
                }
            }
            if (Request.QueryString["isComplete"] != null)
            {
                switch (Request.QueryString["isComplete"].ToLower())
                {
                    case "true":
                        this.isComplete = true; break;
                    case "false":
                        this.isComplete = false; break;
                    default:
                        this.isComplete = null; break;
                }

                if (this.isComplete == null)
                {
                    rblIsComplete.SelectedValue = "null";
                }
                else
                {
                    rblIsComplete.SelectedValue = this.isComplete.ToString().ToLower();
                }
            }
        }

        protected void txtCurrentPage_OnTextChanged(object sender, EventArgs e)
        {
            TextBox t = (TextBox)sender;

            int selectedPage = Convert.ToInt32(t.Text);
            int maxPages = (dpSearchFilesResult.TotalRowCount / dpSearchFilesResult.PageSize) + 1;

            if (selectedPage >= 1 && selectedPage <= maxPages)
            {
                int startRowIndex = (selectedPage - 1) * dpSearchFilesResult.PageSize;

                if (startRowIndex <= dpSearchFilesResult.TotalRowCount)
                {
                    dpSearchFilesResult.SetPageProperties(startRowIndex, dpSearchFilesResult.PageSize, true);
                }
            }
            else
            {
                t.Text = ((dpSearchFilesResult.StartRowIndex / dpSearchFilesResult.PageSize) + 1).ToString();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            this.SetSearchData();
        }

        protected void odsSearchFilesResult_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            this.GetSearchData();

            e.InputParameters["sessionToken"] = base.SessionToken;
            e.InputParameters["fileID"] = this.fileID;
            if (this.fileName.Contains('*'))
            {
                e.InputParameters["fileName"] = this.fileName;
            }
            else
            {
                e.InputParameters["fileName"] = string.Format("*{0}*", this.fileName);
            }
            e.InputParameters["hashMD5"] = this.hashMD5;
            e.InputParameters["hashSHA1"] = this.hashSHA1;
            e.InputParameters["minSize"] = this.minSize;
            e.InputParameters["maxSize"] = this.maxSize;
            e.InputParameters["startDate"] = this.startDate;
            e.InputParameters["endDate"] = this.endDate;
            e.InputParameters["isDeleted"] = this.isDeleted;
            e.InputParameters["isComplete"] = this.isComplete;
            e.InputParameters["metaName"] = this.metaName;
            e.InputParameters["metaValue"] = this.metaValue;
            e.InputParameters["offset"] = this.offset;
            e.InputParameters["pageSize"] = this.pageSize;
        }

        protected void odsSearchFilesResult_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }

            List<FileProperties> fileList = e.ReturnValue as List<FileProperties>;
            if (fileList != null)
            {
                this.totalResults = long.Parse(e.OutputParameters["totalResults"].ToString());

                string currentPageSize = StringHelper.ToByteString(fileList.Skip(dpSearchFilesResult.StartRowIndex).Take(dpSearchFilesResult.PageSize).Sum(f => f.fileSize));
                string totalFilesSize = StringHelper.ToByteString(fileList.Sum(f => f.fileSize));
                Label lblData = lvSearchFilesResult.FindControl("lblData") as Label;
                if (lblData != null)
                {
                    if (fileList.Count > dpSearchFilesResult.PageSize)
                    {
                        lblData.Text = lblData.Text = string.Format("Files from {0} to {1}, {2}<br />", dpSearchFilesResult.StartRowIndex, dpSearchFilesResult.StartRowIndex + dpSearchFilesResult.PageSize, currentPageSize);
                    }
                    else
                    {
                        lblData.Text = string.Empty;
                    }
                    lblData.Text += string.Format("{0} file(s) returned by search, {1}", fileList.Count, totalFilesSize);
                }

                // Show pager if there is not enough files
                if (fileList.Count > dpSearchFilesResult.PageSize)
                {
                    dpSearchFilesResult.Visible = true;
                }
            }
        }

        protected void odsSearchFilesResult_Updating(object sender, ObjectDataSourceMethodEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;

            string newFileName = ((TextBox)lvSearchFilesResult.EditItem.FindControl("txtFileName")).Text;
            e.InputParameters["newFileName"] = newFileName;
        }

        protected void odsSearchFilesResult_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected void odsSearchFilesResult_Deleting(object sender, ObjectDataSourceMethodEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
        }

        protected void odsSearchFilesResult_Deleted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected string GetFileID()
        {
            string fid = Eval("fileID").ToString();
            if ((bool)Eval("isDeleted"))
            {
                fid += "(d)";
            }
            if (!(bool)Eval("isComplete"))
            {
                fid += "(i)";
            }
            return fid;
        }

        protected string GetFileName(string fileName, bool isDeleted, bool isComplete)
        {
            string fn = fileName;
            if (isDeleted)
            {
                fn = "<strike>" + fileName + "</strike>";
            }
            if (!isComplete)
            {
                fn = "<em>" + fn + "</em>";
            }
            return fn;
        }

        protected string GetReplicationURL()
        {
            StringBuilder url = new StringBuilder(String.Format("~/Secure/Replication.aspx?fid={0}", Eval("fileID")));
            if (Eval("replicationPolicyID") != null)
            {
                url.Append("&rpid=" + Eval("replicationPolicyID"));
            }
            return url.ToString();
        }

        protected string GetMetadataURL()
        {
            StringBuilder url = new StringBuilder(String.Format("~/Secure/Metadata.aspx?fid={0}", Eval("fileID")));
            return url.ToString();
        }

        protected void lvSearchFilesResult_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                ListViewDataItem currentItem = (ListViewDataItem)e.Item;
                FileProperties fp = (FileProperties)currentItem.DataItem;

                // Show / Hide image buttons
                if (fp.isDeleted)
                {
                    ImageButton btnEdit = (ImageButton)e.Item.FindControl("btnEdit");
                    btnEdit.Enabled = false;
                    btnEdit.Visible = false;
                    ImageButton btnDelete = (ImageButton)e.Item.FindControl("btnDelete");
                    btnDelete.Visible = false;
                    ImageButton btnUndelete = (ImageButton)e.Item.FindControl("btnUndelete");
                    btnUndelete.Visible = true;
                }

                //  If editing set focus on textbox and set default button
                if (currentItem.DisplayIndex == lvSearchFilesResult.EditIndex)
                {
                    currentItem.FindControl("txtFileName").Focus();
                    this.Form.DefaultButton = currentItem.FindControl("btnUpdate").UniqueID;
                }
            }
        }

        protected void lvSearchFilesResult_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (String.Equals(e.CommandName, "Undelete"))
            {
                ListViewDataItem currentItem = (ListViewDataItem)e.Item;
                long fileID = (long)lvSearchFilesResult.DataKeys[currentItem.DisplayIndex].Value;

                try
                {
                    using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                    {
                        svcProxy.UndeleteFile(base.SessionToken, fileID);
                    }
                }
                catch (FaultException ex)
                {
                    base.HandleException(ex);
                }
                lvSearchFilesResult.DataBind();
            }
        }

        protected void ddlSearchResultPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            CookieHelper.SetValue(CommonConstants.COOKIE_SETTINGS_PREFIX + Context.User.Identity.Name, CommonConstants.COOKIE_SETTINGS_PAGESIZEUI_KEY, ddlSearchResultPageSize.SelectedValue);
            dpSearchFilesResult.PageSize = int.Parse(ddlSearchResultPageSize.SelectedValue);
        }
    }
}
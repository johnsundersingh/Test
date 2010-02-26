//********************************************************************
// 
//  file:  Replication.aspx.cs
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
using System.Collections.Generic;
using System.ServiceModel;

namespace DioWeb.Secure
{
    public partial class Replication : DioBasePage
    {
        public long FileID
        {
            get { return Convert.ToInt64(ViewState["fid"]); }
            set { ViewState["fid"] = value; }
        }
        public int SetReplicationPolicyID
        {
            get { return Convert.ToInt32(ViewState["rpid"]); }
            set { ViewState["rpid"] = value; }
        }
        public int DefaultReplicationPolicyID
        {
            get { return Convert.ToInt32(ViewState["drpid"]); }
            set { ViewState["drpid"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                GetIDsFromQueryString();
                BindStorageTypes();
                SetDefaultReplicationPolicyRow();
            }
        }

        private void GetIDsFromQueryString()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["fid"]))
            {
                this.FileID = long.Parse(Request.QueryString["fid"]);
            }
            else
            {
                Response.Redirect("~/Secure/Search.aspx");
            }
            if (!string.IsNullOrEmpty(Request.QueryString["rpid"]))
            {
                this.SetReplicationPolicyID = int.Parse(Request.QueryString["rpid"]);
            }
        }

        private void BindStorageTypes()
        {
            // Bind storage types DropDownList
            DropDownList ddlStorageTypes = lvPhysicalFiles.FindControl("ddlStorageTypes") as DropDownList;
            if (ddlStorageTypes != null)
            {
                ddlStorageTypes.DataSource = base.GetStorageTypes();
                ddlStorageTypes.DataBind();
            }
        }

        private void SetDefaultReplicationPolicyRow()
        {
            try
            {
                using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                {
                    this.DefaultReplicationPolicyID = svcProxy.GetDefaultReplicationPolicy(base.SessionToken).replicationPolicyID;
                }
            }
            catch (FaultException ex)
            {
                base.HandleException(ex);
            }
        }


        protected void lvReplicationPolicies_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                ListViewDataItem currentItem = (ListViewDataItem)e.Item;
                ReplicationPolicy rp = (ReplicationPolicy)currentItem.DataItem;

                if (rp.replicationPolicyID == this.DefaultReplicationPolicyID)
                {
                    // Set as selected
                    ((ListView)sender).SelectedIndex = currentItem.DisplayIndex;
                }

                if (rp.replicationPolicyID == this.SetReplicationPolicyID)
                {
                    // Disable btnSetToFile button
                    ImageButton btnSetToFile = (ImageButton)currentItem.FindControl("btnSetToFile");
                    btnSetToFile.Visible = false;
                    btnSetToFile.Enabled = false;
                }
                
                //  If editing set focus on textbox and set default button
                if (currentItem.DisplayIndex == lvReplicationPolicies.EditIndex)
                {
                    currentItem.FindControl("txtDefaultNumOnline").Focus();
                    this.Form.DefaultButton = currentItem.FindControl("btnUpdate").UniqueID;
                }
            }
        }

        protected void lvReplicationPolicies_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (String.Equals(e.CommandName, "SetToFile"))
            {
                ListViewDataItem currentItem = (ListViewDataItem)e.Item;
                int replicationPolicyID = (int)lvReplicationPolicies.DataKeys[currentItem.DisplayIndex].Value;

                try
                {
                    using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                    {
                        svcProxy.SetReplicationPolicy(base.SessionToken, this.FileID, replicationPolicyID);
                        ((MasterPages.Common)this.Master).ShowMessage(string.Format("Replication policy successfully applied to logical file ID#{0}", this.FileID), MessageTypes.Success);
                        Response.Redirect(String.Format(Request.AppRelativeCurrentExecutionFilePath + "?fid={0}&rpid={1}", this.FileID, replicationPolicyID));
                    }
                }
                catch (FaultException ex)
                {
                    base.HandleException(ex);
                }
            }
        }

        protected void lvReplicationPolicies_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.DefaultReplicationPolicyID = (int)lvReplicationPolicies.SelectedValue;
            try
            {
                using (DioService.DiomedeStorageClient svcProxy = new DioWeb.DioService.DiomedeStorageClient())
                {
                    svcProxy.SetDefaultReplicationPolicy(this.SessionToken, this.DefaultReplicationPolicyID);
                    ((MasterPages.Common)this.Master).ShowMessage(string.Format("Replication policy ID#{0} was set as default.", this.DefaultReplicationPolicyID), MessageTypes.Success);
                }
            }
            catch (FaultException ex)
            {
                base.HandleException(ex);
            }
        }


        protected void odsReplicationPolicies_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
        }

        protected void odsReplicationPolicies_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected void odsReplicationPolicies_Updating(object sender, ObjectDataSourceMethodEventArgs e)
        {
            TextBox textbox = new TextBox();

            ReplicationPolicy rp = new ReplicationPolicy();

            rp.replicationPolicyID = (int)lvReplicationPolicies.DataKeys[lvReplicationPolicies.EditIndex].Value;

            textbox = lvReplicationPolicies.EditItem.FindControl("txtDefaultNumOnline") as TextBox;
            if (!string.IsNullOrEmpty(textbox.Text))
            {
                rp.defaultNumOnline = int.Parse(textbox.Text);
            }
            textbox = lvReplicationPolicies.EditItem.FindControl("txtDefaultNumNearline") as TextBox;
            if (!string.IsNullOrEmpty(textbox.Text))
            {
                rp.defaultNumNearline = int.Parse(textbox.Text);
            }
            textbox = lvReplicationPolicies.EditItem.FindControl("txtDefaultNumOffline") as TextBox;
            if (!string.IsNullOrEmpty(textbox.Text))
            {
                rp.defaultNumOffline = int.Parse(textbox.Text);
            }
            textbox = lvReplicationPolicies.EditItem.FindControl("txtLastAccessTriggerHours") as TextBox;
            if (!string.IsNullOrEmpty(textbox.Text))
            {
                rp.lastAccessTriggerHours = int.Parse(textbox.Text);
            }
            textbox = lvReplicationPolicies.EditItem.FindControl("txtLastAccessTriggerNumOnline") as TextBox;
            if (!string.IsNullOrEmpty(textbox.Text))
            {
                rp.lastAccessTriggerNumOnline = int.Parse(textbox.Text);
            }
            textbox = lvReplicationPolicies.EditItem.FindControl("txtLastAccessTriggerNumNearline") as TextBox;
            if (!string.IsNullOrEmpty(textbox.Text))
            {
                rp.lastAccessTriggerNumNearline = int.Parse(textbox.Text);
            }
            textbox = lvReplicationPolicies.EditItem.FindControl("txtLastAccessTriggerNumOffline") as TextBox;
            if (!string.IsNullOrEmpty(textbox.Text))
            {
                rp.lastAccessTriggerNumOffline = int.Parse(textbox.Text);
            }
            textbox = lvReplicationPolicies.EditItem.FindControl("txtExpireHours") as TextBox;
            if (!string.IsNullOrEmpty(textbox.Text))
            {
                rp.expireHours = int.Parse(textbox.Text);
            }

            e.InputParameters["sessionToken"] = base.SessionToken;
            e.InputParameters["replicationPolicy"] = rp;
            e.InputParameters.Remove("replicationPolicyID"); // Don't know why this parameter is automatically generated
        }

        protected void odsReplicationPolicies_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected void odsReplicationPolicies_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
        {
            TextBox textbox = new TextBox();

            e.InputParameters["sessionToken"] = base.SessionToken;

            textbox = lvReplicationPolicies.InsertItem.FindControl("txtDefaultNumOnline") as TextBox;
            if (string.IsNullOrEmpty(textbox.Text))
            {
                e.InputParameters["defaultNumOnline"] = 0;
            }
            textbox = lvReplicationPolicies.InsertItem.FindControl("txtDefaultNumNearline") as TextBox;
            if (string.IsNullOrEmpty(textbox.Text))
            {
                e.InputParameters["defaultNumNearline"] = 0;
            }
            textbox = lvReplicationPolicies.InsertItem.FindControl("txtDefaultNumOffline") as TextBox;
            if (string.IsNullOrEmpty(textbox.Text))
            {
                e.InputParameters["defaultNumOffline"] = 0;
            }
            textbox = lvReplicationPolicies.InsertItem.FindControl("txtLastAccessTriggerHours") as TextBox;
            if (string.IsNullOrEmpty(textbox.Text))
            {
                e.InputParameters["lastAccessTriggerHours"] = 0;
            }
            textbox = lvReplicationPolicies.InsertItem.FindControl("txtLastAccessTriggerNumOnline") as TextBox;
            if (string.IsNullOrEmpty(textbox.Text))
            {
                e.InputParameters["lastAccessTriggerNumOnline"] = 0;
            }
            textbox = lvReplicationPolicies.InsertItem.FindControl("txtLastAccessTriggerNumNearline") as TextBox;
            if (string.IsNullOrEmpty(textbox.Text))
            {
                e.InputParameters["lastAccessTriggerNumNearline"] = 0;
            }
            textbox = lvReplicationPolicies.InsertItem.FindControl("txtLastAccessTriggerNumOffline") as TextBox;
            if (string.IsNullOrEmpty(textbox.Text))
            {
                e.InputParameters["lastAccessTriggerNumOffline"] = 0;
            }
        }

        protected void odsReplicationPolicies_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected void odsReplicationPolicies_Deleting(object sender, ObjectDataSourceMethodEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
        }

        protected void odsReplicationPolicies_Deleted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }


        protected void lvPhysicalFiles_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "Replicate":
                    DropDownList ddlStorageTypes = lvPhysicalFiles.FindControl("ddlStorageTypes") as DropDownList;
                    int storageTypeID = int.Parse(ddlStorageTypes.SelectedItem.Value);
                    try
                    {
                        using (DioService.DiomedeStorageClient svcProxy = new DioWeb.DioService.DiomedeStorageClient())
                        {
                            svcProxy.ReplicateFile(this.SessionToken, this.FileID, storageTypeID, null);
                            lvPhysicalFiles.DataBind();
                        }
                    }
                    catch (FaultException ex)
                    {
                        base.HandleException(ex);
                    }
                    break;
                case "Unreplicate":
                    ListViewDataItem currentItem = (ListViewDataItem)e.Item;
                    long physicalFileID = (long)lvPhysicalFiles.DataKeys[currentItem.DisplayIndex].Value;
                    try
                    {
                        using (DioService.DiomedeStorageClient svcProxy = new DioWeb.DioService.DiomedeStorageClient())
                        {
                            svcProxy.UnreplicateFile(this.SessionToken, physicalFileID);
                            lvPhysicalFiles.DataBind();
                        }
                    }
                    catch (FaultException ex)
                    {
                        base.HandleException(ex);
                    }
                    break;
                default:
                    break;
            }
        }

        protected void odsPhysicalFiles_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
        }

        protected void odsPhysicalFiles_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }
    }
}

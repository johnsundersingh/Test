//********************************************************************
// 
//  file:  MyDiomede.aspx.cs
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
using System.Web.Security;
using System.ServiceModel;

namespace DioWeb.Secure
{
    public partial class MyDiomede : DioWeb.App_Classes.DioBasePage
    {
        protected override void OnInit(EventArgs e)
        {
            base.RequireSSL = true;
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SetFirstEmailAsSelected();
                BindEmails();
                BindStorageData();
                litUserName.Text = HttpContext.Current.User.Identity.Name;
            }
            else
            {
                if (!string.IsNullOrEmpty(hfTabMyDiomede.Value))
                {
                    tabMyDiomede.ActiveTabIndex = int.Parse(hfTabMyDiomede.Value);
                }
            }
        }

        #region userinfo
        protected void btnDeleteUser_Click(object sender, EventArgs e)
        {
            try
            {
                using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                {
                    svcProxy.DeleteUser(base.SessionToken);
                }
            }
            catch (FaultException ex)
            {
                base.HandleException(ex);
            }

            FormsAuthentication.SignOut();
            Response.Redirect(string.Format("{0}?{1}={2}", FormsAuthentication.LoginUrl, DioWeb.App_Classes.CommonConstants.LOGIN_MESSAGE_KEY, DioWeb.App_Classes.CommonConstants.LOGIN_MESSAGE_USER_DELETED_VALUE));
        }

        protected void ucUserInfo_ServiceError(object sender, ServiceExceptionEventArgs e)
        {
            ucUserInfo.ServiceErrorHandled = base.HandleException(e.Exception);
        }
        #endregion

        #region usercreditcard
        protected void ucUserCreditCard_ServiceError(object sender, ServiceExceptionEventArgs e)
        {
            ucUserCreditCard.ServiceErrorHandled = base.HandleException(e.Exception);
        }
        #endregion

        #region password
        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                    {
                        svcProxy.ChangePassword(base.SessionToken, txtCurrentPassword.Text, txtNewPassword.Text);
                        ((MasterPages.Common)this.Master).ShowMessage("Password successfully changed.", MessageTypes.Success);
                    }
                }
                catch (FaultException ex)
                {
                    base.HandleException(ex);
                }
            }
        }
        #endregion
        
        #region emails
        private void SetFirstEmailAsSelected()
        {
            // Default email address is the first one retrieved
            lvEmails.SelectedIndex = 0;
        }

        private void BindEmails()
        {
            try
            {
                using (DioService.DiomedeStorageClient svcProxy = new DioWeb.DioService.DiomedeStorageClient())
                {
                    List<string> emails = svcProxy.GetEmailAddresses(base.SessionToken);

                    if (emails.Count > 0)
                    {
                        var bindableEmails = from e in emails
                                             select new { Email = e };
                        this.lvEmails.DataSource = bindableEmails.ToList();
                    }
                }
            }
            catch (FaultException ex)
            {
                base.HandleException(ex);
            }
            this.lvEmails.DataBind();
        }

        private void BindEmails(List<string> emails)
        {
            if (emails.Count > 0)
            {
                var bindableEmails = from e in emails
                                     select new { Email = e };
                this.lvEmails.DataSource = bindableEmails.ToList();
                this.lvEmails.DataBind();
            }
        }

        protected void lvEmails_SelectedIndexChanging(object sender, ListViewSelectEventArgs e)
        {
            Label lblEmail = lvEmails.Items[e.NewSelectedIndex].FindControl("lblEmail") as Label;
            string email = lblEmail != null ? lblEmail.Text : string.Empty;

            if (!string.IsNullOrEmpty(email))
            {
                try
                {
                    using (DioService.DiomedeStorageClient svcProxy = new DioWeb.DioService.DiomedeStorageClient())
                    {
                        svcProxy.SetPrimaryEmailAddress(base.SessionToken, email);
                        lvEmails.SelectedIndex = e.NewSelectedIndex;
                        ((MasterPages.Common)this.Master).ShowMessage(string.Format("E-mail {0} has been set as primary.", email), MessageTypes.Success);
                    }
                }
                catch (FaultException ex)
                {
                    base.HandleException(ex);
                    e.Cancel = true;
                }
            }

            List<string> emails = new List<string>();
            foreach (ListViewDataItem item in lvEmails.Items)
            {
                emails.Add(lvEmails.DataKeys[item.DisplayIndex].Value.ToString());
            }
            BindEmails(emails);
        }

        protected void lvEmails_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            string email = lvEmails.DataKeys[e.ItemIndex].Value as String;

            if (!string.IsNullOrEmpty(email))
            {
                try
                {
                    using (DioService.DiomedeStorageClient svcProxy = new DioWeb.DioService.DiomedeStorageClient())
                    {
                        svcProxy.DeleteEmailAddress(base.SessionToken, email);
                        SetFirstEmailAsSelected();
                        BindEmails();
                        ((MasterPages.Common)this.Master).ShowMessage(string.Format("E-mail {0} has been successfully deleted.", email), MessageTypes.Success);
                    }
                }
                catch (FaultException ex)
                {
                    base.HandleException(ex);
                    e.Cancel = true;
                }
            }
        }

        protected void lvEmails_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            if (Page.IsValid)
            {
                TextBox txtAddEmail = lvEmails.InsertItem.FindControl("txtAddEmail") as TextBox;
                string email = txtAddEmail != null ? txtAddEmail.Text : string.Empty;

                if (!string.IsNullOrEmpty(email))
                {
                    try
                    {
                        using (DioService.DiomedeStorageClient svcProxy = new DioWeb.DioService.DiomedeStorageClient())
                        {
                            svcProxy.AddEmailAddress(base.SessionToken, email);
                            txtAddEmail.Text = string.Empty;
                            SetFirstEmailAsSelected();
                            BindEmails();
                        }
                    }
                    catch (Exception ex)
                    {
                        base.HandleException(ex);
                        e.Cancel = true;
                    }
                }
            }
        }
        #endregion

        #region storage stats
        private void BindStorageData()
        {
            using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
            {
                try
                {
                    SearchFilesTotalInfo sfti = svcProxy.SearchFilesTotal(base.SessionToken, null, "", "", "", null, null, null, null, null, "", "");
                    litCreatedDate.Text = sfti.createdDate.ToString();
                    litStoredFiles.Text = sfti.fileCount.ToString() + " (" + StringHelper.ToByteString(sfti.fileBytes) + ")";
                    litUploadedFiles.Text = sfti.uploadCount.ToString() + " (" + StringHelper.ToByteString(sfti.uploadBytes) + ")"; ;
                    litDownloadedFiles.Text = sfti.downloadCount.ToString() + " (" + StringHelper.ToByteString(sfti.downloadBytes) + ")"; ;
                    litDeletedFiles.Text = sfti.deletedFileCount.ToString() + " (" + StringHelper.ToByteString(sfti.deletedFileBytes) + ")"; ;
                    lvStorageStatistics.DataSource = sfti.storageTotalInfo;

                    base.SetStorageTypes();
                }
                catch (FaultException ex)
                {
                    base.HandleException(ex);
                }
                lvStorageStatistics.DataBind();
            }
        }

        protected void btnUsageStatistics_Click(object sender, EventArgs e)
        {
            gvUsageStatistics.DataSourceID = odsUsageStatistics.ID;
            ((LinkButton)sender).Visible = false;
        }

        protected void odsUsageStatistics_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            DateTime weekAgoDate = DateTime.Now.AddDays(-7);

            e.InputParameters["sessionToken"] = base.SessionToken;
            e.InputParameters["startDate"] = weekAgoDate;
            e.InputParameters["endDate"] = null;
            e.InputParameters["offset"] = DioWeb.App_Classes.CommonConstants.DEFAULT_OFFSET.ToString();
            e.InputParameters["pageSize"] = DioWeb.App_Classes.CommonConstants.DEFAULT_PAGE_SIZE.ToString();
        }

        protected void odsUsageStatistics_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }
        #endregion

        #region logs
        protected void btnLoginLog_Click(object sender, EventArgs e)
        {
            lvLoginLog.DataSourceID = odsLoginLog.ID;
            ((LinkButton)sender).Visible = false;
        }
        protected void odsLoginLog_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
            e.InputParameters["startDate"] = null;
            e.InputParameters["endDate"] = null;
            e.InputParameters["loginIP"] = string.Empty;
            e.InputParameters["offset"] = DioWeb.App_Classes.CommonConstants.DEFAULT_OFFSET.ToString();
            e.InputParameters["pageSize"] = DioWeb.App_Classes.CommonConstants.DEFAULT_PAGE_SIZE.ToString();
        }
        protected void odsLoginLog_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected void btnDownloadLog_Click(object sender, EventArgs e)
        {
            lvDownloadLog.DataSourceID = odsDownloadLog.ID;
            ((LinkButton)sender).Visible = false;
        }
        protected void odsDownloadLog_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
            e.InputParameters["fileID"] = null;
            e.InputParameters["startDate"] = null;
            e.InputParameters["endDate"] = null;
            e.InputParameters["downloadToken"] = string.Empty;
            e.InputParameters["downloaderIP"] = string.Empty;
            e.InputParameters["offset"] = DioWeb.App_Classes.CommonConstants.DEFAULT_OFFSET.ToString();
            e.InputParameters["pageSize"] = DioWeb.App_Classes.CommonConstants.DEFAULT_PAGE_SIZE.ToString();
        }
        protected void odsDownloadLog_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected void btnUploadLog_Click(object sender, EventArgs e)
        {
            lvUploadLog.DataSourceID = odsUploadLog.ID;
            ((LinkButton)sender).Visible = false;
        }
        protected void odsUploadLog_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
            e.InputParameters["fileID"] = null;
            e.InputParameters["startDate"] = null;
            e.InputParameters["endDate"] = null;
            e.InputParameters["uploaderIP"] = string.Empty;
            e.InputParameters["offset"] = DioWeb.App_Classes.CommonConstants.DEFAULT_OFFSET.ToString();
            e.InputParameters["pageSize"] = DioWeb.App_Classes.CommonConstants.DEFAULT_PAGE_SIZE.ToString();
        }
        protected void odsUploadLog_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }
        #endregion

        #region billing
        protected void btnInvoiceLog_Click(object sender, EventArgs e)
        {
            lvInvoiceLog.DataSourceID = odsInvoiceLog.ID;
            ((LinkButton)sender).Visible = false;
        }
        protected void odsInvoiceLog_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
            e.InputParameters["startDate"] = null;
            e.InputParameters["endDate"] = null;
            e.InputParameters["invoiceStatus"] = null; //InvoiceStatus.paid;
        }
        protected void odsInvoiceLog_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        //protected void btnPaymentLog_Click(object sender, EventArgs e)
        //{
        //    lvPaymentLog.DataSourceID = odsPaymentLog.ID;
        //    ((LinkButton)sender).Visible = false;
        //}
        //protected void odsPaymentLog_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        //{
        //    e.InputParameters["sessionToken"] = base.SessionToken;
        //    e.InputParameters["startDate"] = DateTime.MinValue;
        //    e.InputParameters["endDate"] = DateTime.Today;
        //}
        //protected void odsPaymentLog_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        //{
        //    if (e.Exception != null)
        //    {
        //        e.ExceptionHandled = base.HandleServiceError(e.Exception);
        //    }
        //}
        #endregion
    }
}
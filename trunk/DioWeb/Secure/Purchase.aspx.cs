//********************************************************************
// 
//  file:  Purchase.aspx.cs
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
using System.ServiceModel;

namespace DioWeb.Secure
{
    public partial class Purchase : DioWeb.App_Classes.DioBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SetCreditCardInstructionsText();
                base.SetStorageTypes();
            }
        }

        private void SetCreditCardInstructionsText()
        {
            try
            {
                using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                {
                    UserInfo ui = svcProxy.GetUserInfo(base.SessionToken);
                    if (!string.IsNullOrEmpty(ui.cardNumber))
                    {
                        litCreditCard.Text = string.Format("Please select the Diomede products you would like to purchase using your credit card ending in {0}.", ui.cardNumber);
                    }
                }
            }
            catch (FaultException ex)
            {
                base.HandleException(ex);
            }
        }


        protected void lvAllProducts_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (string.Equals(e.CommandName, "PurchaseProduct"))
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                int pid = (int)lvAllProducts.DataKeys[dataItem.DisplayIndex].Value;

                try
                {
                    using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                    {
                        svcProxy.PurchaseProduct(base.SessionToken, pid);
                    }
                }
                catch (FaultException ex)
                {
                    base.HandleException(ex);
                }
                lvMyProducts.DataBind();
            }
        }

        protected void lvAllContracts_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (string.Equals(e.CommandName, "PurchaseContract"))
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                int cid = (int)lvAllContracts.DataKeys[dataItem.DisplayIndex].Value;

                try
                {
                    using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                    {
                        svcProxy.PurchaseContract(base.SessionToken, cid);
                    }
                }
                catch (FaultException ex)
                {
                    base.HandleException(ex);
                }
                lvMyContracts.DataBind();
            }
        }

        protected void lvMyProducts_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (string.Equals(e.CommandName, "CancelProduct"))
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                Label lblProductID = lvMyProducts.Items[dataItem.DisplayIndex].FindControl("lblProductID") as Label;
                string productID = lblProductID != null ? lblProductID.Text : string.Empty;
                int pid = int.Parse(productID);

                try
                {
                    using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                    {
                        svcProxy.CancelProduct(base.SessionToken, pid);
                    }
                }
                catch (FaultException ex)
                {
                    base.HandleException(ex);
                }
                lvMyProducts.DataBind();
            }
        }

        protected void lvMyContracts_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

            if (string.Equals(e.CommandName, "CancelContract"))
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                long ucid = (long)lvMyContracts.DataKeys[dataItem.DisplayIndex].Value;

                try
                {
                    using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                    {
                        svcProxy.CancelContract(base.SessionToken, ucid);
                    }
                }
                catch (FaultException ex)
                {
                    base.HandleException(ex);
                }
                lvMyContracts.DataBind();
            }
        }


        protected void odsMyProducts_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
        }

        protected void odsMyContracts_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["sessionToken"] = base.SessionToken;
        }

        protected void odsAllProducts_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected void odsMyProducts_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected void odsAllContracts_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }

        protected void odsMyContracts_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = base.HandleException(e.Exception);
            }
        }
    }
}
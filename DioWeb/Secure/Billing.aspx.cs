//********************************************************************
// 
//  file:  Billing.aspx.cs
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

namespace DioWeb.Secure
{
    public partial class Billing : DioWeb.App_Classes.DioBasePage
    {
        protected override void OnInit(EventArgs e)
        {
            base.RequireSSL = true;
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ckbAgreementReq_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = (ckbAgreement.Checked);
        }

        protected void ucUserCreditCard_ServiceError(object sender, ServiceExceptionEventArgs e)
        {
            ucUserCreditCard.ServiceErrorHandled = base.HandleException(e.Exception);
        }

        protected void btnPurchase_Click(object sender, ImageClickEventArgs e)
        {
            if (Page.IsValid)
            {
                if (ucUserCreditCard.IsEditMode)
                {
                    ((MasterPages.Common)this.Page.Master).ShowMessage("You must save your credit card info before proceeding", MessageTypes.Error);
                }
                else
                {
                    Response.Redirect("~/Secure/Purchase.aspx");
                }
            }
        }
    }
}

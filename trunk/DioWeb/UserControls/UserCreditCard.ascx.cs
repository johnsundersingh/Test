using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DioWeb.App_Classes;
using System.ServiceModel;

namespace DioWeb.UserControls
{
    public partial class UserCreditCard : System.Web.UI.UserControl
    {
        public delegate void ServiceFaultException(object sender, ServiceExceptionEventArgs e);
        public event ServiceFaultException ServiceError;
        public bool ServiceErrorHandled { get; set; }

        public string ValidationGroup { get; set; }
        public bool IsEditMode
        {
            get
            {
                if (lvUserCreditCard.EditIndex == -1)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }

        private DioService.UserInfo userInfo;

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void lvUserCreditCard_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            this.userInfo = new DioService.UserInfo();

            this.userInfo.cardName = ((TextBox)lvUserCreditCard.Items[e.ItemIndex].FindControl("txtCardName")).Text;
            this.userInfo.cardNumber = ((TextBox)lvUserCreditCard.Items[e.ItemIndex].FindControl("txtCardNumber")).Text;
            this.userInfo.cardExpiryYear = Convert.ToInt32(((TextBox)lvUserCreditCard.Items[e.ItemIndex].FindControl("txtCardExpiryYear")).Text);
            this.userInfo.cardExpiryMonth = Convert.ToInt32(((TextBox)lvUserCreditCard.Items[e.ItemIndex].FindControl("txtCardExpiryMonth")).Text);
            this.userInfo.cardCvv2 = ((TextBox)lvUserCreditCard.Items[e.ItemIndex].FindControl("txtCardCvv2")).Text;
            this.userInfo.cardAddress1 = ((TextBox)lvUserCreditCard.Items[e.ItemIndex].FindControl("txtCardAddress1")).Text;
            this.userInfo.cardAddress2 = !string.IsNullOrEmpty(((TextBox)lvUserCreditCard.Items[e.ItemIndex].FindControl("txtCardAddress2")).Text) ? ((TextBox)lvUserCreditCard.Items[e.ItemIndex].FindControl("txtCardAddress2")).Text : string.Empty;
            this.userInfo.cardCity = ((TextBox)lvUserCreditCard.Items[e.ItemIndex].FindControl("txtCardCity")).Text;
            this.userInfo.cardState = ((TextBox)lvUserCreditCard.Items[e.ItemIndex].FindControl("txtCardState")).Text;
            this.userInfo.cardZip = ((TextBox)lvUserCreditCard.Items[e.ItemIndex].FindControl("txtCardZip")).Text;
            this.userInfo.cardCountry = ((TextBox)lvUserCreditCard.Items[e.ItemIndex].FindControl("txtCardCountry")).Text;
        }

        #region Pre-ObjectDataSource command execution - parameters initialization, etc
        protected void odsUserCreditCard_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["sessionToken"] = ((DioBasePage)this.Page).SessionToken;
        }

        protected void odsUserCreditCard_Updating(object sender, ObjectDataSourceMethodEventArgs e)
        {
            e.InputParameters["sessionToken"] = ((DioBasePage)this.Page).SessionToken;
            e.InputParameters["userInfo"] = this.userInfo;
        }

        protected void odsUserCreditCard_Deleting(object sender, ObjectDataSourceMethodEventArgs e)
        {
            e.InputParameters["sessionToken"] = ((DioBasePage)this.Page).SessionToken;
            e.InputParameters["userInfoType"] = DioService.UserInfoType.allBillingInfo;
        }
        #endregion

        #region Post-ObjectDataSource command execution - error handling, etc
        protected void odsUserCreditCard_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                this.ServiceError(this, new ServiceExceptionEventArgs(e.Exception.GetBaseException()));
                e.ExceptionHandled = this.ServiceErrorHandled;
            }

            if (e.ReturnValue != null)
            {
                DioService.UserInfo ui = (DioService.UserInfo)e.ReturnValue;
                if (!ui.paymentMethod.Equals(DioService.PaymentMethods.creditCard))
                {
                    lvUserCreditCard.EditIndex = 0;
                }
            }
        }

        protected void odsUserCreditCard_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                this.ServiceError(this, new ServiceExceptionEventArgs(e.Exception.GetBaseException()));
                e.ExceptionHandled = this.ServiceErrorHandled;
            }
        }

        protected void odsUserCreditCard_Deleted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                this.ServiceError(this, new ServiceExceptionEventArgs(e.Exception.GetBaseException()));
                e.ExceptionHandled = this.ServiceErrorHandled;
            }
        }
        #endregion
    }
}
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
    public partial class UserInfo : System.Web.UI.UserControl
    {
        public delegate void ServiceFaultException(object sender, ServiceExceptionEventArgs e);
        public event ServiceFaultException ServiceError;

        public bool ServiceErrorHandled { get; set; }

        private DioService.UserInfo userInfo;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lvUserInfo_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            DioWeb.DioService.UserInfo ui;
            using (DioWeb.DioService.DiomedeStorageClient svcProxy = new DioWeb.DioService.DiomedeStorageClient())
            {
                try
                {
                    ui = svcProxy.GetUserInfo(((DioBasePage)this.Page).SessionToken);
                    this.userInfo = new DioWeb.DioService.UserInfo()
                    {
                        firstName = ((TextBox)lvUserInfo.Items[e.ItemIndex].FindControl("txtFirstName")).Text,
                        lastName = ((TextBox)lvUserInfo.Items[e.ItemIndex].FindControl("txtLastName")).Text,
                        companyName = ((TextBox)lvUserInfo.Items[e.ItemIndex].FindControl("txtCompanyName")).Text,
                        websiteUrl = ((TextBox)lvUserInfo.Items[e.ItemIndex].FindControl("txtWebsiteUrl")).Text,
                        phone = ((TextBox)lvUserInfo.Items[e.ItemIndex].FindControl("txtPhone")).Text,

                        cardName = ui.cardName,
                        cardExpiryYear = ui.cardExpiryYear,
                        cardExpiryMonth = ui.cardExpiryMonth,
                        cardAddress1 = ui.cardAddress1,
                        cardAddress2 = ui.cardAddress2,
                        cardCity = ui.cardCity,
                        cardState = ui.cardState,
                        cardZip = ui.cardZip,
                        cardCountry = ui.cardCountry
                    };
                }
                catch (FaultException ex)
                {
                    this.ServiceError(this, new ServiceExceptionEventArgs(ex));
                    e.Cancel = this.ServiceErrorHandled;
                }
            }
        }

        #region Pre-ObjectDataSource command execution - parameters initialization, etc
        protected void odsUserInfo_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["sessionToken"] = ((DioBasePage)this.Page).SessionToken;
        }

        protected void odsUserInfo_Updating(object sender, ObjectDataSourceMethodEventArgs e)
        {
            e.InputParameters["sessionToken"] = ((DioBasePage)this.Page).SessionToken;
            e.InputParameters["userInfo"] = this.userInfo;
        }

        protected void odsUserInfo_Deleting(object sender, ObjectDataSourceMethodEventArgs e)
        {
            e.InputParameters["sessionToken"] = ((DioBasePage)this.Page).SessionToken;
            e.InputParameters["userInfoType"] = DioService.UserInfoType.allUserInfo;
        }
        #endregion

        #region Post-ObjectDataSource command execution - error handling, etc
        protected void odsUserInfo_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                this.ServiceError(this, new ServiceExceptionEventArgs(e.Exception.GetBaseException()));
                e.ExceptionHandled = this.ServiceErrorHandled;
            }
        }

        protected void odsUserInfo_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                this.ServiceError(this, new ServiceExceptionEventArgs(e.Exception.GetBaseException()));
                e.ExceptionHandled = this.ServiceErrorHandled;
            }
        }

        protected void odsUserInfo_Deleted(object sender, ObjectDataSourceStatusEventArgs e)
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
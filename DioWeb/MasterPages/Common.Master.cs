using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DioWeb.DioService;
using DioWeb.App_Classes;

namespace DioWeb.MasterPages
{
    public partial class Common : System.Web.UI.MasterPage
    {
        public int ScriptManagerTimeout
        {
            get
            {
                return smDioWeb.AsyncPostBackTimeout;
            }
            set
            {
                smDioWeb.AsyncPostBackTimeout = value;
            }
        }
        public UpdatePanel MessageUpdatePanel
        {
            get { return upnlMessage; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ctrlLoginStatus_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            DioWeb.App_Classes.DioBasePage basePage = this.Page as DioWeb.App_Classes.DioBasePage;

            string st;
            if (basePage != null)
            {
                st = basePage.SessionToken;
            }
            else
            {
                System.Web.Security.FormsIdentity fid = HttpContext.Current.User.Identity as System.Web.Security.FormsIdentity;
                st = fid.Ticket.UserData;
            }
            try
            {
                using (DiomedeStorageClient svcProxy = new DiomedeStorageClient())
                {
                    svcProxy.Logout(st);
                }
            }
            catch (Exception ex)
            {
                this.ShowMessage(ex.GetBaseException().Message, MessageTypes.Error);
                e.Cancel = true;
            }
        }

        protected void ctrlLoginStatus_LoggedOut(object sender, EventArgs e)
        {
            Response.Redirect(System.Web.Security.FormsAuthentication.DefaultUrl);
        }

        public void ShowMessage(string msg, MessageTypes type)
        {
            lblMessage.Text += string.Format("{0} <br />", msg);
            if (type == MessageTypes.Success)
            {
                pnlMessage.CssClass = "message " + MessageTypes.Success.ToString().ToLower();
            }
            else if (type == MessageTypes.Error)
            {
                pnlMessage.CssClass = "message " + MessageTypes.Error.ToString().ToLower();
            }
        }

        //protected void smDioWeb_AsyncPostBackError(object sender, AsyncPostBackErrorEventArgs e)
        //{
        //    ScriptManager.GetCurrent(this.Page).AsyncPostBackErrorMessage = e.Exception.GetBaseException().Message;
        //}
    }
}

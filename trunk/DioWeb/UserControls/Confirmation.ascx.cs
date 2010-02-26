using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace DioWeb.UserControls
{
    public partial class Confirmation : System.Web.UI.UserControl
    {
        public string TargetControlID
        {
            set
            {
                this.cbeConfirm.TargetControlID = value;
                this.mpeConfirm.TargetControlID = value;
            }
        }
        public string ConfirmText
        {
            get { return this.litConfirmText.Text; }
            set { this.litConfirmText.Text = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
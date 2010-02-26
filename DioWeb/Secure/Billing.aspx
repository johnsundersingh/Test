<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="Billing.aspx.cs" Inherits="DioWeb.Secure.Billing" Title="DioWeb :: Billing" %>

<%@ Register Src="../UserControls/UserCreditCard.ascx" TagName="UserCreditCard" TagPrefix="uc1" %>
<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">

    <script type="text/javascript" language="javascript">
        function ValidateAgreementCheckBox(oSrc, args) {
            args.IsValid = $get("<%= ckbAgreement.ClientID %>").checked;
        }
    </script>

</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <div>
        <h4>
            Please enter your credit card information to use for Diomede purchases. Product
            selection will be on the next page.
        </h4>
        <asp:CheckBox ID="ckbAgreement" runat="server" Text="I agree to Diomede's <a href='http://www.diomedestorage.com/service_agreement.aspx' target='_blank'>Terms of Service and Service Agreement</a>."
            Checked="true" />
        <asp:CustomValidator ID="ckbAgreementReq" runat="server" ClientValidationFunction="ValidateAgreementCheckBox"
            Display="Dynamic" ErrorMessage="<br />Terms of Service and Service Agreement must be checked."
            ToolTip="Terms of Service and Service Agreement must be checked." ValidationGroup="UserCreditCard"
            OnServerValidate="ckbAgreementReq_ServerValidate"></asp:CustomValidator>
    </div>
    <br />
    <uc1:UserCreditCard ID="ucUserCreditCard" runat="server" OnServiceError="ucUserCreditCard_ServiceError"
        ValidationGroup="UserCreditCard" />
    <br />
    <div>
        <asp:ImageButton ID="btnPurchase" runat="server" AlternateText="Next" ImageUrl="~/Images/Buttons/next.png"
            ToolTip="Continue with the subscription process" ValidationGroup="UserCreditCard"
            OnClick="btnPurchase_Click" />
    </div>
</asp:Content>

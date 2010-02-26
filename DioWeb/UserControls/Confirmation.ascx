<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Confirmation.ascx.cs"
    Inherits="DioWeb.UserControls.Confirmation" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<style type="text/css">
    .modalBackground
    {
        background-color: #333;
        filter: alpha(opacity=70);
        opacity: 0.7;
    }
    .modalPopup
    {
        text-align: center;
        width: 100%;
        color: #333;
        background: #fff url(../Images/content_bg.jpg) 0 0 repeat-x;
        padding-bottom: 15px;
    }
</style>
<asp:Panel ID="pnlConfirmControls" runat="server" Style="display: none;" CssClass="modalPopup">
    <h4>
        <asp:Image ID="imgWarning" runat="server" ImageUrl="~/Images/Icons/warning.png" ImageAlign="AbsMiddle" />
        <asp:Literal ID="litConfirmText" runat="server"></asp:Literal>
    </h4>
    <asp:ImageButton ID="btnOK" runat="server" ImageUrl="~/Images/Icons/check.png" AlternateText="Yes"
        ToolTip="Yes" />
    &nbsp;&nbsp;&nbsp;
    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/Images/Icons/cancel.png"
        AlternateText="No" ToolTip="No" />
</asp:Panel>
<act:ModalPopupExtender ID="mpeConfirm" runat="server" PopupControlID="pnlConfirmControls"
    BackgroundCssClass="modalBackground" OkControlID="btnOK" CancelControlID="btnCancel"
    Y="0">
</act:ModalPopupExtender>
<act:ConfirmButtonExtender ID="cbeConfirm" runat="server" DisplayModalPopupID="mpeConfirm">
</act:ConfirmButtonExtender>

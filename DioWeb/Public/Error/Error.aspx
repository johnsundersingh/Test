<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="Error.aspx.cs" Inherits="DioWeb.Public.Error.Error" Title="DioWeb :: Unhandled Exception" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <div class="message error">
        <asp:Image ID="imgError" runat="server" AlternateText="Error" ToolTip="Error!" ImageUrl="~/Images/Icons/error.png"
            ImageAlign="AbsMiddle" />
        <asp:Label ID="lblErrorMessage" runat="server" Text="Unhandled Exception"></asp:Label>
    </div>
    <div>
        <span>Sorry, an unexpected error has occurred. Please try again.</span>
    </div>
    <br />
    <div>
        <asp:HyperLink ID="lnkBack" runat="server" Text="Back" Enabled="false" />
        &nbsp;|&nbsp;
        <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Default.aspx">Home</asp:HyperLink>
    </div>
</asp:Content>

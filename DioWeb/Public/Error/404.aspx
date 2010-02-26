<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="404.aspx.cs" Inherits="DioWeb.Public.Error._04" Title="DioWeb :: Page not found" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <div class="message warning">
        <asp:Image ID="imgAlert" runat="server" AlternateText="Alert" ToolTip="Page Not Found!"
            ImageUrl="~/Images/Icons/warning.png" ImageAlign="AbsMiddle" />
        <asp:Label ID="lblErrorMessage" runat="server" Text="Page not found"></asp:Label>
    </div>
    <div>
        <span>Sorry, the page you requested was not found.</span>
    </div>
    <br />
    <div>
        Return to the
        <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Default.aspx">home page</asp:HyperLink>
    </div>
</asp:Content>

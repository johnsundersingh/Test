<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="Home.aspx.cs" Inherits="DioWeb.Secure.Home" Title="DioWeb :: Home" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <img alt="Diomede Storage" src="../Images/logo.png" />
    <h3>
        <asp:Literal ID="litGreeting" runat="server"></asp:Literal>
    </h3>
    <p>
        <em>Warning: files in trial accounts are deleted every 24 hours.</em></p>
    <p>
        <strong>Purchase a Diomede subscription for your account today, so your data will be
            safe<br />
            and you can start to fully experience the best cloud storage service available.</strong></p>
    <asp:RadioButtonList ID="rblAccount" runat="server">
        <asp:ListItem Text="Yes, continue with subscription purchase." Value="true" Selected="True" />
        <asp:ListItem Text="No thanks, I’d like to continue testing…" Value="false" />
    </asp:RadioButtonList>
    <asp:ImageButton ID="btnGo" runat="server" AlternateText="Go!" ToolTip="Go!" ImageUrl="~/Images/Buttons/go.png"
        OnClick="btnGo_Click" />
</asp:Content>

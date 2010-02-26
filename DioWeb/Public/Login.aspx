<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="DioWeb.Public.Login" Title="DioWeb :: Login" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <asp:Login ID="ctrlLogin" runat="server" CreateUserText="Create New User" CreateUserUrl="~/Public/CreateUser.aspx"
        OnAuthenticate="ctrlLogin_Authenticate" OnLoggedIn="ctrlLogin_LoggedIn">
        <LayoutTemplate>
            <table border="0">
                <tr>
                    <td align="center" colspan="2">
                        <asp:Label ID="FailureText" runat="server" EnableViewState="False" Visible="false" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h3 class="title">
                            <asp:Image ID="imgLogin" runat="server" ImageUrl="~/Images/Icons/unlock.png" ImageAlign="AbsMiddle" />
                            Login to your account
                        </h3>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblUserName" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                            SetFocusOnError="true" ErrorMessage="User Name is required." ToolTip="User Name is required."
                            ValidationGroup="ctrlLogin">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblPassword" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                            SetFocusOnError="true" ErrorMessage="Password is required." ToolTip="Password is required."
                            ValidationGroup="ctrlLogin">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td align="left">
                        <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me next time." />
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td align="left">
                        <asp:HyperLink ID="lnkPasswordRecovery" runat="server" NavigateUrl="~/Public/ResetPassword.aspx">Forgot your password?</asp:HyperLink>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td align="left">
                        <asp:ImageButton ID="btnLogin" runat="server" CommandName="Login" ValidationGroup="ctrlLogin"
                            AlternateText="Login" ToolTip="Login" ImageUrl="~/Images/Buttons/login.png" />
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
    </asp:Login>
</asp:Content>

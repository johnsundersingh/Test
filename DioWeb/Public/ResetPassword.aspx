<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="ResetPassword.aspx.cs" Inherits="DioWeb.Public.ResetPassword" Title="DioWeb :: Reset Password" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <h3 class="title">
        <asp:Image ID="imgResetPassword" runat="server" ImageUrl="~/Images/Icons/mail_pass.png"
            ImageAlign="AbsMiddle" />
        Forgot Your Password?
    </h3>
    <table border="0">
        <tr>
            <td align="center" colspan="2">
                Enter your UserName to receive your new password
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="lblUserName" runat="server" AssociatedControlID="txtUserName">UserName:</asp:Label>
            </td>
            <td align="left">
                <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="txtUserNameRequired" runat="server" ControlToValidate="txtUserName"
                    ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="ResetPassword">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td align="left" colspan="2">
                <asp:ImageButton ID="btnResetPassword" runat="server" ValidationGroup="ResetPassword"
                    OnClick="btnResetPassword_Click" AlternateText="ResetPassword" ToolTip="Reset Password"
                    ImageUrl="~/Images/Buttons/reset_password.png" />
            </td>
        </tr>
    </table>
</asp:Content>

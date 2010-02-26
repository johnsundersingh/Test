<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="CreateUser.aspx.cs" Inherits="DioWeb.Public.CreateUser" Title="DioWeb :: Create User" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">

    <script type="text/javascript" language="javascript">
        function ValidateAgreementCheckBox(oSrc, args) {
            args.IsValid = $get("<%= ckbAgreement.ClientID %>").checked;
        }
    </script>

</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <asp:Wizard ID="wzdCreateUser" runat="server" DisplaySideBar="False">
        <WizardSteps>
            <asp:WizardStep ID="stepCreateUser" runat="server" Title="Sign Up for Your New Account"
                AllowReturn="false">
                <table border="0">
                    <tr>
                        <td colspan="2">
                            <h3 class="title">
                                <asp:Image ID="imgCreateUser" runat="server" ImageUrl="~/Images/Icons/user_add.png"
                                    ImageAlign="AbsMiddle" />
                                Create a new user account
                            </h3>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                SetFocusOnError="true" ErrorMessage="User Name is required." ToolTip="User Name is required."
                                ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                SetFocusOnError="true" ErrorMessage="Password is required." ToolTip="Password is required."
                                ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password:</asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required."
                                SetFocusOnError="true" ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                SetFocusOnError="true" ErrorMessage="E-mail is required." ToolTip="E-mail is required."
                                ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td align="left">
                            <asp:CheckBox ID="ckbAgreement" runat="server" Text="I agree to Diomede's <br /> <a href='http://www.diomedestorage.com/service_agreement.aspx' target='_blank'>Terms of Service and Service Agreement</a>." />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td align="left">
                            <asp:ImageButton ID="btnCreateUser" runat="server" CausesValidation="true" ValidationGroup="CreateUser"
                                OnClick="btnCreateUser_Click" AlternateText="CreateUser" ToolTip="Create New Account"
                                ImageUrl="~/Images/Buttons/create_user.png" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                SetFocusOnError="true" ControlToValidate="ConfirmPassword" Display="Dynamic"
                                ErrorMessage="The Password and Confirmation Password must match." ValidationGroup="CreateUser"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:RegularExpressionValidator ID="EmailRegExp" runat="server" ControlToValidate="Email"
                                SetFocusOnError="true" Display="Dynamic" ErrorMessage="Please enter a valid e-mail."
                                ValidationExpression="^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.(([0-9]{1,3})|([a-zA-Z]{2,3})|(aero|coop|info|museum|name))$"
                                ValidationGroup="CreateUser"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:CustomValidator ID="ckbAgreementReq" runat="server" ClientValidationFunction="ValidateAgreementCheckBox"
                                Display="Dynamic" ErrorMessage="Terms of Service and Service Agreement must be checked."
                                SetFocusOnError="true" ToolTip="Terms of Service and Service Agreement must be checked."
                                ValidationGroup="CreateUser" OnServerValidate="ckbAgreementReq_ServerValidate"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Label ID="ErrorMessage" runat="server" EnableViewState="False" />
                        </td>
                    </tr>
                </table>
            </asp:WizardStep>
        </WizardSteps>
        <FinishNavigationTemplate>
        </FinishNavigationTemplate>
    </asp:Wizard>
</asp:Content>

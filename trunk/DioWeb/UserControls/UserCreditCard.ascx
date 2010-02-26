<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserCreditCard.ascx.cs"
    Inherits="DioWeb.UserControls.UserCreditCard" %>
<%@ Register Src="Confirmation.ascx" TagName="Confirmation" TagPrefix="dio" %>
<asp:ListView ID="lvUserCreditCard" runat="server" DataSourceID="odsUserCreditCard"
    OnItemUpdating="lvUserCreditCard_ItemUpdating">
    <LayoutTemplate>
        <table id="itemPlaceholderContainer" runat="server" border="0" rules="none">
            <tr id="itemPlaceholder" runat="server">
            </tr>
        </table>
    </LayoutTemplate>
    <ItemTemplate>
        <tr>
            <td align="right">
                Name on credit card:
            </td>
            <td align="left">
                <asp:Label ID="lblCardName" runat="server" Text='<%# Eval("cardName") != string.Empty ? Eval("cardName") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Credit card number:
            </td>
            <td align="left">
                <asp:Label ID="lblCardNumber" runat="server" Text='<%# Eval("cardNumber") != string.Empty ? Eval("cardNumber") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Credit card expiration year (yyyy):
            </td>
            <td align="left">
                <asp:Label ID="lblCardExpiryYear" runat="server" Text='<%# (int)Eval("cardExpiryYear") > 0 ? Eval("cardExpiryYear") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Credit card expiration month (mm):
            </td>
            <td align="left">
                <asp:Label ID="lblCardExpiryMonth" runat="server" Text='<%# (int)Eval("cardExpiryMonth") > 0 ? Eval("cardExpiryMonth") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Credit card CVV (3 or 4 digits):
            </td>
            <td align="left">
                <asp:Label ID="lblCardCvv2" runat="server" Text='<%# Eval("cardCvv2") != string.Empty ? Eval("cardCvv2") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Address1:
            </td>
            <td align="left">
                <asp:Label ID="lblCardAddress1" runat="server" Text='<%# Eval("cardAddress1") != string.Empty ? Eval("cardAddress1") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Address2:
            </td>
            <td align="left">
                <asp:Label ID="lblCardAddress2" runat="server" Text='<%# Eval("cardAddress2") != string.Empty ? Eval("cardAddress2") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                City:
            </td>
            <td align="left">
                <asp:Label ID="lblCardCity" runat="server" Text='<%# Eval("cardCity") != string.Empty ? Eval("cardCity") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                State:
            </td>
            <td align="left">
                <asp:Label ID="lblCardState" runat="server" Text='<%# Eval("cardState") != string.Empty ? Eval("cardState") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Zip:
            </td>
            <td align="left">
                <asp:Label ID="lblCardZip" runat="server" Text='<%# Eval("cardZip") != string.Empty ? Eval("cardZip") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                Country:
            </td>
            <td align="left">
                <asp:Label ID="lblCardCountry" runat="server" Text='<%# Eval("cardCountry") != string.Empty ? Eval("cardCountry") : "<em>none</em>" %>' />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td align="left">
                <asp:ImageButton ID="btnEdit" runat="server" CommandName="Edit" ToolTip="Edit billing information"
                    AlternateText="Edit" ImageUrl="~/Images/Icons/edit.png" />
                <asp:ImageButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip="Delete billing information"
                    AlternateText="Delete" ImageUrl="~/Images/Icons/delete.png" />
            </td>
            <td>
                <dio:Confirmation ID="ucDeleteUserCreditCardConfirmation" runat="server" TargetControlID="btnDelete"
                    ConfirmText="Are you sure you want to delete credit card information?" />
            </td>
        </tr>
    </ItemTemplate>
    <EditItemTemplate>
        <tr>
            <td align="right">
                Name on credit card:
            </td>
            <td align="left">
                <asp:TextBox ID="txtCardName" runat="server" Text='<%# Eval("cardName") %>' />
                <asp:RequiredFieldValidator ID="txtCardNametxtRequired" runat="server" ControlToValidate="txtCardName"
                    ValidationGroup='<%# this.ValidationGroup %>' SetFocusOnError="true">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Credit card number:
            </td>
            <td align="left">
                <asp:TextBox ID="txtCardNumber" runat="server" />
                <asp:RequiredFieldValidator ID="txtCardNumberRequired" runat="server" ControlToValidate="txtCardNumber"
                    ValidationGroup='<%# this.ValidationGroup %>' SetFocusOnError="true">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Credit card expiration year (yyyy):
            </td>
            <td align="left">
                <asp:TextBox ID="txtCardExpiryYear" runat="server" Text='<%# (int)Eval("cardExpiryYear") > 0 ? Eval("cardExpiryYear") : string.Empty %>' />
                <asp:RequiredFieldValidator ID="txtCardExpiryYearRequired" runat="server" ControlToValidate="txtCardExpiryYear"
                    ValidationGroup='<%# this.ValidationGroup %>' SetFocusOnError="true">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="txtCardExpiryYearCompare" runat="server" ErrorMessage="Invalid year value."
                    ControlToValidate="txtCardExpiryYear" Type="Integer" ValueToCompare='<%# DateTime.Now.Year %>'
                    Operator="GreaterThanEqual" ValidationGroup='<%# this.ValidationGroup %>' SetFocusOnError="true"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Credit card expiration month (mm):
            </td>
            <td align="left">
                <asp:TextBox ID="txtCardExpiryMonth" runat="server" Text='<%# (int)Eval("cardExpiryMonth") > 0 ? Eval("cardExpiryMonth") : string.Empty %>' />
                <asp:RequiredFieldValidator ID="txtCardExpiryMonthRequired" runat="server" ControlToValidate="txtCardExpiryMonth"
                    ValidationGroup='<%# this.ValidationGroup %>' SetFocusOnError="true">*</asp:RequiredFieldValidator>
                <asp:RangeValidator ID="txtCardExpiryMonthRange" runat="server" ErrorMessage="Invalid month value."
                    ControlToValidate="txtCardExpiryMonth" Type="Integer" MinimumValue="1" MaximumValue="12"
                    ValidationGroup='<%# this.ValidationGroup %>' SetFocusOnError="true"></asp:RangeValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Credit card CVV (3 or 4 digits):
            </td>
            <td align="left">
                <asp:TextBox ID="txtCardCvv2" runat="server" />
                <asp:RequiredFieldValidator ID="txtCardCvv2Required" runat="server" ControlToValidate="txtCardCvv2"
                    ValidationGroup='<%# this.ValidationGroup %>' SetFocusOnError="true">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Address1:
            </td>
            <td align="left">
                <asp:TextBox ID="txtCardAddress1" runat="server" Text='<%# Eval("cardAddress1") %>' />
                <asp:RequiredFieldValidator ID="txtCardAddress1Required" runat="server" ControlToValidate="txtCardAddress1"
                    ValidationGroup='<%# this.ValidationGroup %>' SetFocusOnError="true">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Address2:
            </td>
            <td align="left">
                <asp:TextBox ID="txtCardAddress2" runat="server" Text='<%# Eval("cardAddress2") %>' />
            </td>
        </tr>
        <tr>
            <td align="right">
                City:
            </td>
            <td align="left">
                <asp:TextBox ID="txtCardCity" runat="server" Text='<%# Eval("cardCity") %>' />
                <asp:RequiredFieldValidator ID="txtCardCityRequired" runat="server" ControlToValidate="txtCardCity"
                    ValidationGroup='<%# this.ValidationGroup %>' SetFocusOnError="true">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                State:
            </td>
            <td align="left">
                <asp:TextBox ID="txtCardState" runat="server" Text='<%# Eval("cardState") %>' />
                <asp:RequiredFieldValidator ID="txtCardStateRequired" runat="server" ControlToValidate="txtCardState"
                    ValidationGroup='<%# this.ValidationGroup %>' SetFocusOnError="true">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Zip:
            </td>
            <td align="left">
                <asp:TextBox ID="txtCardZip" runat="server" Text='<%# Eval("cardZip") %>' />
                <asp:RequiredFieldValidator ID="txtCardZipRequired" runat="server" ControlToValidate="txtCardZip"
                    ValidationGroup='<%# this.ValidationGroup %>' SetFocusOnError="true">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Country:
            </td>
            <td align="left">
                <asp:TextBox ID="txtCardCountry" runat="server" Text='<%# Eval("cardCountry") %>' />
                <asp:RequiredFieldValidator ID="txtCardCountryRequired" runat="server" ControlToValidate="txtCardCountry"
                    ValidationGroup='<%# this.ValidationGroup %>' SetFocusOnError="true">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td align="left">
                <asp:ImageButton ID="btnUpdate" runat="server" CommandName="Update" ToolTip="Update"
                    AlternateText="Update" ImageUrl="~/Images/Icons/check.png" ValidationGroup='<%# this.ValidationGroup %>' />
                <asp:ImageButton ID="btnCancel" runat="server" CommandName="Cancel" ToolTip="Cancel"
                    AlternateText="Cancel" ImageUrl="~/Images/Icons/cancel.png" CausesValidation="false" />
            </td>
        </tr>
    </EditItemTemplate>
    <EmptyDataTemplate>
        <table>
            <tr>
                <td>
                    No data was returned.
                </td>
            </tr>
        </table>
    </EmptyDataTemplate>
</asp:ListView>
<asp:ObjectDataSource ID="odsUserCreditCard" runat="server" TypeName="DioWeb.DioService.DiomedeStorageClient"
    SelectMethod="GetUserInfo" OnSelecting="odsUserCreditCard_Selecting" UpdateMethod="SetUserInfo"
    OnUpdating="odsUserCreditCard_Updating" DeleteMethod="DeleteUserInfo" OnDeleting="odsUserCreditCard_Deleting"
    OnSelected="odsUserCreditCard_Selected" OnDeleted="odsUserCreditCard_Deleted"
    OnUpdated="odsUserCreditCard_Updated">
    <DeleteParameters>
        <asp:Parameter Name="sessionToken" Type="String" />
        <asp:Parameter Name="userInfoType" Type="Object" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="sessionToken" Type="String" />
        <asp:Parameter Name="userInfo" Type="Object" />
    </UpdateParameters>
    <SelectParameters>
        <asp:Parameter Name="sessionToken" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>

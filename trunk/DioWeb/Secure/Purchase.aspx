<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="Purchase.aspx.cs" Inherits="DioWeb.Secure.Purchase" Title="DioWeb :: Subscribe" %>

<%@ Register Src="../UserControls/UserCreditCard.ascx" TagName="UserCreditCard" TagPrefix="uc1" %>
<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <h4>
        <asp:Literal ID="litCreditCard" runat="server" Text="Please enter your credit card information before making a purchase."></asp:Literal>
    </h4>
    <div>
        <h3>
            Available Products
        </h3>
        <asp:ListView ID="lvAllProducts" runat="server" DataSourceID="odsAllProducts" DataKeyNames="productID"
            OnItemCommand="lvAllProducts_ItemCommand">
            <LayoutTemplate>
                <table id="itemPlaceholderContainer" runat="server" border="0">
                    <tr id="itemPlaceholder" runat="server">
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td align="left" colspan="3">
                        <strong>
                            <asp:Label ID="lblProductID" runat="server" Text='<%# Eval("productID", "Product {0}: ") %>' /></strong>
                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("name") %>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        Minimum Monthly Fee:
                    </td>
                    <td align="right">
                        <asp:Label ID="lblMinMonthlyFee" runat="server" Text='<%# DioWeb.App_Classes.StringHelper.ToMoneyString((int)Eval("minMonthlyFee")) %>' />
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        Support Fee:
                    </td>
                    <td align="right">
                        <asp:Label ID="supportFeeLabel" runat="server" Text='<%# DioWeb.App_Classes.StringHelper.ToMoneyString((int)Eval("supportFee")) %>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                    </td>
                </tr>
                <asp:ListView ID="lvComponents" runat="server" DataSource='<%# Eval("components") %>'
                    DataKeyNames="storageTypeID">
                    <LayoutTemplate>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td align="right" colspan="2">
                                <asp:Label ID="lblStorageType" runat="server" Text='<%# base.GetStorageTypeName((int)Eval("storageTypeID")) %>' />
                                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("meterType", "{0}: ") %>' />
                            </td>
                            <td align="right">
                                <asp:Label ID="lblRatePerGB" runat="server" Text='<%# DioWeb.App_Classes.StringHelper.ToMoneyString((int)Eval("ratePerGB")) %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <span>No data was returned.</span>
                    </EmptyDataTemplate>
                </asp:ListView>
                <tr>
                    <td colspan="3">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:LinkButton ID="btnBuyProduct" runat="server" CommandName="PurchaseProduct" CommandArgument="productID">Buy Product</asp:LinkButton>
                    </td>
                </tr>
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                <span>No data was returned.</span>
            </EmptyDataTemplate>
        </asp:ListView>
        <asp:ObjectDataSource ID="odsAllProducts" runat="server" SelectMethod="GetAllProducts"
            TypeName="DioWeb.DioService.DiomedeStorageClient" OnSelected="odsAllProducts_Selected">
        </asp:ObjectDataSource>
        <br />
        <h3>
            My Products
        </h3>
        <asp:ListView ID="lvMyProducts" runat="server" DataSourceID="odsMyProducts" OnItemCommand="lvMyProducts_ItemCommand">
            <LayoutTemplate>
                <table id="itemPlaceholderContainer" runat="server" border="0">
                    <tr>
                        <th>
                            Product
                        </th>
                        <th>
                            With Support
                        </th>
                        <th>
                        </th>
                    </tr>
                    <tr id="itemPlaceholder" runat="server">
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lblProduct" runat="server" Text='<%# Eval("product.productID", "{0}: ") + Eval("product.name") %>' />
                    </td>
                    <td>
                        <asp:CheckBox ID="ckbWithSupport" runat="server" Checked='<%# Eval("withSupport") %>'
                            Enabled="false" />
                    </td>
                    <td>
                        <asp:Label ID="lblProductID" runat="server" Text='<%# Eval("product.productID") %>'
                            Visible="false" />
                        <asp:LinkButton ID="btnCancelProduct" runat="server" CommandName="CancelProduct">Cancel</asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
            <EmptyDataTemplate>
                <table>
                    <tr>
                        <td>
                            No products have been purchased yet.
                        </td>
                    </tr>
                </table>
            </EmptyDataTemplate>
        </asp:ListView>
        <asp:ObjectDataSource ID="odsMyProducts" runat="server" OnSelecting="odsMyProducts_Selecting"
            SelectMethod="GetMyProducts" TypeName="DioWeb.DioService.DiomedeStorageClient"
            OnSelected="odsMyProducts_Selected">
            <SelectParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    <div>
        <h3>
            Contracts
        </h3>
        <asp:ListView ID="lvAllContracts" runat="server" DataSourceID="odsAllContracts" DataKeyNames="contractID"
            OnItemCommand="lvAllContracts_ItemCommand">
            <LayoutTemplate>
                <table id="itemPlaceholderContainer" runat="server" border="0">
                    <tr id="itemPlaceholder" runat="server">
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td align="left">
                        <asp:Label ID="lblContractID" runat="server" Text='<%# Eval("contractID", "{0}:") %>' />
                    </td>
                    <td align="left">
                        <asp:Label ID="lblTerm" runat="server" Text='<%# Eval("term", "{0}-Months") %>' />
                    </td>
                    <td align="right">
                        <asp:Label ID="lblCommittedGB" runat="server" Text='<%# Eval("components[0].committedGB", "{0} GB") %>' />
                    </td>
                    <td align="right">
                        <asp:Label ID="lblStorageType" runat="server" Text='<%# base.GetStorageTypeName((int)Eval("components[0].storageTypeID")) %>' />
                    </td>
                    <td align="right">
                        <asp:Label ID="lblRatePerTerm" runat="server" Text='<%# DioWeb.App_Classes.StringHelper.ToMoneyString((int)Eval("ratePerTerm")) %>' />
                    </td>
                    <td align="right">
                        <asp:LinkButton ID="btnBuyContract" runat="server" CommandName="PurchaseContract"
                            CommandArgument="contractID">Buy Contract</asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
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
        <asp:ObjectDataSource ID="odsAllContracts" runat="server" SelectMethod="GetAllContracts"
            TypeName="DioWeb.DioService.DiomedeStorageClient" OnSelected="odsAllContracts_Selected">
        </asp:ObjectDataSource>
        <br />
        <h3>
            My Contracts
        </h3>
        <asp:ListView ID="lvMyContracts" runat="server" DataSourceID="odsMyContracts" DataKeyNames="userContractID"
            OnItemCommand="lvMyContracts_ItemCommand">
            <LayoutTemplate>
                <table id="itemPlaceholderContainer" runat="server" border="0">
                    <tr>
                        <th>
                            Contract
                        </th>
                        <th>
                            Start Date
                        </th>
                        <th>
                            End Date
                        </th>
                        <th>
                        </th>
                    </tr>
                    <tr id="itemPlaceholder" runat="server">
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lblContract" runat="server" Text='<%# Eval("contract.contractID", "{0}: ") + Eval("contract.term", "{0}-Months") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("startDate") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblEndDate" runat="server" Text='<%# Eval("endDate") %>' />
                    </td>
                    <td>
                        <asp:LinkButton ID="btnCancelContract" runat="server" CommandName="CancelContract"
                            CommandArgument="userContractID">Cancel</asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
            <EmptyDataTemplate>
                <table>
                    <tr>
                        <td>
                            No contracts have been purchased yet.
                        </td>
                    </tr>
                </table>
            </EmptyDataTemplate>
        </asp:ListView>
        <asp:ObjectDataSource ID="odsMyContracts" runat="server" OnSelecting="odsMyContracts_Selecting"
            SelectMethod="GetMyContracts" TypeName="DioWeb.DioService.DiomedeStorageClient"
            OnSelected="odsMyContracts_Selected">
            <SelectParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    <br />
    <p>
        All purchases are subject to the terms and conditions of <a href='http://www.diomedestorage.com/service_agreement.aspx'
            target='_blank'>Diomede Storage Service Agreement</a>.
    </p>
</asp:Content>

<%@ Page Language="C#" MasterPageFile="~/MasterPages/Common.Master" AutoEventWireup="true"
    CodeBehind="Metadata.aspx.cs" Inherits="DioWeb.Secure.Metadata" Title="DioWeb :: Metadata" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="cphMain" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <div>
        <h3 class="title">
            All Metadata
        </h3>
        <asp:ListView ID="lvMetadata" runat="server" DataSourceID="odsMetadata" DataKeyNames="metaDataID"
            InsertItemPosition="LastItem" OnItemCommand="lvMetadata_ItemCommand" OnItemDataBound="lvMetadata_ItemDataBound">
            <LayoutTemplate>
                <table width="100%">
                    <tr>
                        <td>
                            <table id="itemPlaceholderContainer" runat="server" class="table" rules="none">
                                <tr>
                                    <th>
                                        ID
                                    </th>
                                    <th>
                                        Name
                                    </th>
                                    <th>
                                        Value
                                    </th>
                                    <th>
                                        Created Date
                                    </th>
                                    <th colspan="3">
                                    </th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:DataPager ID="dpMetadata" runat="server" PageSize="10">
                                <Fields>
                                    <asp:NumericPagerField ButtonType="Link" ButtonCount="10" />
                                </Fields>
                            </asp:DataPager>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lblMetaDataID" runat="server" Text='<%# Eval("metaDataID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("name") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblValue" runat="server" Text='<%# Eval("value") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblCreatedDate" runat="server" Text='<%# Eval("createdDate") %>' />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnEdit" runat="server" CommandName="Edit" ToolTip="Edit metadata"
                            AlternateText="Edit" ImageUrl="~/Images/Icons/tag_edit.png" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip="Delete metadata"
                            AlternateText="Delete" ImageUrl="~/Images/Icons/tag_delete.png" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnSetToFile" runat="server" CommandName="SetToFile" ToolTip="Set metadata to current file"
                            AlternateText="SetToFile" ImageUrl="~/Images/Icons/down.png" />
                    </td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr class="selected">
                    <td>
                        <asp:Label ID="lblMetaDataID" runat="server" Text='<%# Eval("metaDataID") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("name") %>' />
                        <asp:RequiredFieldValidator ID="txtNameRequired" runat="server" ControlToValidate="txtName"
                            SetFocusOnError="true" ErrorMessage="Metadata Name is required." ToolTip="Metadata Name is required."
                            ValidationGroup="EditMetadata">*</asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:TextBox ID="txtValue" runat="server" Text='<%# Bind("value") %>' />
                        <asp:RequiredFieldValidator ID="txtValueRequired" runat="server" ControlToValidate="txtValue"
                            SetFocusOnError="true" ErrorMessage="Metadata Value is required." ToolTip="Metadata Value is required."
                            ValidationGroup="EditMetadata">*</asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:Label ID="lblCreatedDate" runat="server" Text='<%# Eval("createdDate") %>' />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnUpdate" runat="server" CommandName="Update" ToolTip="Update"
                            AlternateText="Update" ImageUrl="~/Images/Icons/check.png" ValidationGroup="EditMetadata" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnCancel" runat="server" CommandName="Cancel" ToolTip="Cancel"
                            AlternateText="Cancel" ImageUrl="~/Images/Icons/cancel.png" CausesValidation="false" />
                    </td>
                    <td>
                    </td>
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr>
                    <th>
                        Create metadata
                    </th>
                    <th>
                        <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("name") %>' />
                        <asp:RequiredFieldValidator ID="txtNameRequired" runat="server" ControlToValidate="txtName"
                            SetFocusOnError="true" ErrorMessage="Metadata Name is required." ToolTip="Metadata Name is required."
                            ValidationGroup="CreateMetadata">*</asp:RequiredFieldValidator>
                    </th>
                    <th>
                        <asp:TextBox ID="txtValue" runat="server" Text='<%# Bind("value") %>' />
                        <asp:RequiredFieldValidator ID="txtValueRequired" runat="server" ControlToValidate="txtValue"
                            SetFocusOnError="true" ErrorMessage="Metadata Value is required." ToolTip="Metadata Value is required."
                            ValidationGroup="CreateMetadata">*</asp:RequiredFieldValidator>
                    </th>
                    <th>
                    </th>
                    <th>
                    </th>
                    <th>
                        <asp:ImageButton ID="btnInsert" runat="server" CommandName="Insert" ToolTip="Create metadata"
                            AlternateText="Insert" ImageUrl="~/Images/Icons/tag_add.png" ValidationGroup="CreateMetadata" />
                    </th>
                    <th>
                    </th>
                </tr>
            </InsertItemTemplate>
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
        <asp:ObjectDataSource ID="odsMetadata" runat="server" TypeName="DioWeb.DioService.DiomedeStorageClient"
            SelectMethod="GetMetaData" OnSelecting="odsMetadata_Selecting" UpdateMethod="EditMetaData"
            OnUpdating="odsMetadata_Updating" InsertMethod="CreateMetaData" OnInserting="odsMetadata_Inserting"
            DeleteMethod="DeleteMetaData" OnDeleting="odsMetadata_Deleting" OnDeleted="odsMetadata_Deleted"
            OnUpdated="odsMetadata_Updated" OnInserted="odsMetadata_Inserted" OnSelected="odsMetadata_Selected">
            <DeleteParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="metaDataID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="metaDataID" Type="Int32" />
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="value" Type="String" />
            </UpdateParameters>
            <SelectParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="metaDataID" Type="Int32" />
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="value" Type="String" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="value" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </div>
    <div>
        <h3>
            FileID #<%= FileID %>
            Metadata
        </h3>
        <asp:ListView ID="lvFileMetadata" runat="server" DataSourceID="odsFileMetadata" DataKeyNames="metaDataID"
            InsertItemPosition="LastItem">
            <LayoutTemplate>
                <table width="100%">
                    <tr>
                        <td>
                            <table id="itemPlaceholderContainer" runat="server" border="0" class="table" rules="none">
                                <tr>
                                    <th>
                                        ID
                                    </th>
                                    <th>
                                        Name
                                    </th>
                                    <th>
                                        Value
                                    </th>
                                    <th>
                                        Created Date
                                    </th>
                                    <th>
                                    </th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:DataPager ID="dpFileMetadata" runat="server" PageSize="5">
                                <Fields>
                                    <asp:NumericPagerField ButtonType="Link" ButtonCount="10" />
                                </Fields>
                            </asp:DataPager>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lblMetaDataID" runat="server" Text='<%# Eval("metaDataID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("name") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblValue" runat="server" Text='<%# Eval("value") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblCreatedDate" runat="server" Text='<%# Eval("createdDate") %>' />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip="Delete metadata"
                            AlternateText="Delete" ImageUrl="~/Images/Icons/tag_delete.png" />
                    </td>
                </tr>
            </ItemTemplate>
            <InsertItemTemplate>
                <tr>
                    <th>
                        Create file metadata
                    </th>
                    <th>
                        <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("name") %>' />
                        <asp:RequiredFieldValidator ID="txtNameRequired" runat="server" ControlToValidate="txtName"
                            SetFocusOnError="true" ErrorMessage="Metadata Name is required." ToolTip="Metadata Name is required."
                            ValidationGroup="CreateFileMetadata">*</asp:RequiredFieldValidator>
                    </th>
                    <th>
                        <asp:TextBox ID="txtValue" runat="server" Text='<%# Bind("value") %>' />
                        <asp:RequiredFieldValidator ID="txtValueRequired" runat="server" ControlToValidate="txtValue"
                            SetFocusOnError="true" ErrorMessage="Metadata Value is required." ToolTip="Metadata Value is required."
                            ValidationGroup="CreateFileMetadata">*</asp:RequiredFieldValidator>
                    </th>
                    <th>
                    </th>
                    <th>
                        <asp:ImageButton ID="btnInsert" runat="server" CommandName="Insert" ToolTip="Create metadata"
                            AlternateText="Insert" ImageUrl="~/Images/Icons/tag_add.png" ValidationGroup="CreateFileMetadata" />
                    </th>
                </tr>
            </InsertItemTemplate>
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
        <asp:ObjectDataSource ID="odsFileMetadata" runat="server" DeleteMethod="DeleteFileMetaData"
            InsertMethod="CreateFileMetaData" SelectMethod="GetFileMetaData" TypeName="DioWeb.DioService.DiomedeStorageClient"
            OnDeleting="odsFileMetadata_Deleting" OnInserting="odsFileMetadata_Inserting"
            OnSelecting="odsFileMetadata_Selecting" OnDeleted="odsFileMetadata_Deleted" OnInserted="odsFileMetadata_Inserted"
            OnSelected="odsFileMetadata_Selected">
            <DeleteParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="fileID" Type="Int64" />
                <asp:Parameter Name="metaDataID" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="fileID" Type="Int64" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="sessionToken" Type="String" />
                <asp:Parameter Name="fileID" Type="Int64" />
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="value" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>

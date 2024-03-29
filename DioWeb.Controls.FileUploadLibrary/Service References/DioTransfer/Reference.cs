﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.4918
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace darrenjohnstone.net.FileUpload.DioTransfer {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "3.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="UploadWithCreateFileInfo", Namespace="http://data.diomedestorage.com")]
    [System.SerializableAttribute()]
    public partial class UploadWithCreateFileInfo : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string fileNameField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> totalLengthField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string callbackAddressField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string hashField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string fileName {
            get {
                return this.fileNameField;
            }
            set {
                if ((object.ReferenceEquals(this.fileNameField, value) != true)) {
                    this.fileNameField = value;
                    this.RaisePropertyChanged("fileName");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<int> totalLength {
            get {
                return this.totalLengthField;
            }
            set {
                if ((this.totalLengthField.Equals(value) != true)) {
                    this.totalLengthField = value;
                    this.RaisePropertyChanged("totalLength");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(Order=2)]
        public string callbackAddress {
            get {
                return this.callbackAddressField;
            }
            set {
                if ((object.ReferenceEquals(this.callbackAddressField, value) != true)) {
                    this.callbackAddressField = value;
                    this.RaisePropertyChanged("callbackAddress");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(Order=3)]
        public string hash {
            get {
                return this.hashField;
            }
            set {
                if ((object.ReferenceEquals(this.hashField, value) != true)) {
                    this.hashField = value;
                    this.RaisePropertyChanged("hash");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "3.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="UploadInfo", Namespace="http://data.diomedestorage.com")]
    [System.SerializableAttribute()]
    public partial class UploadInfo : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<long> fileIDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<long> offsetField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> bufferLengthField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<bool> isCompleteField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<long> fileID {
            get {
                return this.fileIDField;
            }
            set {
                if ((this.fileIDField.Equals(value) != true)) {
                    this.fileIDField = value;
                    this.RaisePropertyChanged("fileID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<long> offset {
            get {
                return this.offsetField;
            }
            set {
                if ((this.offsetField.Equals(value) != true)) {
                    this.offsetField = value;
                    this.RaisePropertyChanged("offset");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(Order=2)]
        public System.Nullable<int> bufferLength {
            get {
                return this.bufferLengthField;
            }
            set {
                if ((this.bufferLengthField.Equals(value) != true)) {
                    this.bufferLengthField = value;
                    this.RaisePropertyChanged("bufferLength");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(Order=3)]
        public System.Nullable<bool> isComplete {
            get {
                return this.isCompleteField;
            }
            set {
                if ((this.isCompleteField.Equals(value) != true)) {
                    this.isCompleteField = value;
                    this.RaisePropertyChanged("isComplete");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "3.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(Namespace="http://transfer.diomedestorage.com", ConfigurationName="DioTransfer.IDiomedeStorageTransfer", SessionMode=System.ServiceModel.SessionMode.NotAllowed)]
    public interface IDiomedeStorageTransfer {
        
        // CODEGEN: Generating message contract since the wrapper name (UploadWithCreateFileRequest) of message UploadWithCreateFileRequest does not match the default value (UploadWithCreateFile)
        [System.ServiceModel.OperationContractAttribute(Action="UploadWithCreateFile", ReplyAction="http://transfer.diomedestorage.com/IDiomedeStorageTransfer/UploadWithCreateFileRe" +
            "sponse")]
        darrenjohnstone.net.FileUpload.DioTransfer.UploadWithCreateFileResponse UploadWithCreateFile(darrenjohnstone.net.FileUpload.DioTransfer.UploadWithCreateFileRequest request);
        
        // CODEGEN: Generating message contract since the wrapper name (CreateFileRequest) of message CreateFileRequest does not match the default value (CreateFile)
        [System.ServiceModel.OperationContractAttribute(Action="CreateFile", ReplyAction="http://transfer.diomedestorage.com/IDiomedeStorageTransfer/CreateFileResponse")]
        darrenjohnstone.net.FileUpload.DioTransfer.CreateFileResponse CreateFile(darrenjohnstone.net.FileUpload.DioTransfer.CreateFileRequest request);
        
        // CODEGEN: Generating message contract since the operation Upload is neither RPC nor document wrapped.
        [System.ServiceModel.OperationContractAttribute(Action="Upload", ReplyAction="http://transfer.diomedestorage.com/IDiomedeStorageTransfer/UploadResponse")]
        darrenjohnstone.net.FileUpload.DioTransfer.UploadResponse Upload(darrenjohnstone.net.FileUpload.DioTransfer.UploadRequest request);
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "3.0.0.0")]
    [System.ServiceModel.MessageContractAttribute(WrapperName="UploadWithCreateFileRequest", WrapperNamespace="http://transfer.diomedestorage.com", IsWrapped=true)]
    public partial class UploadWithCreateFileRequest {
        
        [System.ServiceModel.MessageHeaderAttribute(Namespace="http://transfer.diomedestorage.com")]
        public string sessionToken;
        
        [System.ServiceModel.MessageHeaderAttribute(Namespace="http://transfer.diomedestorage.com")]
        public darrenjohnstone.net.FileUpload.DioTransfer.UploadWithCreateFileInfo uploadWithCreateFileInfo;
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://transfer.diomedestorage.com", Order=0)]
        public System.IO.Stream content;
        
        public UploadWithCreateFileRequest() {
        }
        
        public UploadWithCreateFileRequest(string sessionToken, darrenjohnstone.net.FileUpload.DioTransfer.UploadWithCreateFileInfo uploadWithCreateFileInfo, System.IO.Stream content) {
            this.sessionToken = sessionToken;
            this.uploadWithCreateFileInfo = uploadWithCreateFileInfo;
            this.content = content;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "3.0.0.0")]
    [System.ServiceModel.MessageContractAttribute(WrapperName="UploadWithCreateFileResponse", WrapperNamespace="http://transfer.diomedestorage.com", IsWrapped=true)]
    public partial class UploadWithCreateFileResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://transfer.diomedestorage.com", Order=0)]
        public long fileID;
        
        public UploadWithCreateFileResponse() {
        }
        
        public UploadWithCreateFileResponse(long fileID) {
            this.fileID = fileID;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "3.0.0.0")]
    [System.ServiceModel.MessageContractAttribute(WrapperName="CreateFileRequest", WrapperNamespace="http://transfer.diomedestorage.com", IsWrapped=true)]
    public partial class CreateFileRequest {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://transfer.diomedestorage.com", Order=0)]
        public string sessionToken;
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://transfer.diomedestorage.com", Order=1)]
        public string fileName;
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://transfer.diomedestorage.com", Order=2)]
        public string callbackAddress;
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://transfer.diomedestorage.com", Order=3)]
        public string hash;
        
        public CreateFileRequest() {
        }
        
        public CreateFileRequest(string sessionToken, string fileName, string callbackAddress, string hash) {
            this.sessionToken = sessionToken;
            this.fileName = fileName;
            this.callbackAddress = callbackAddress;
            this.hash = hash;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "3.0.0.0")]
    [System.ServiceModel.MessageContractAttribute(WrapperName="CreateFileResponse", WrapperNamespace="http://transfer.diomedestorage.com", IsWrapped=true)]
    public partial class CreateFileResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://transfer.diomedestorage.com", Order=0)]
        public long fileID;
        
        public CreateFileResponse() {
        }
        
        public CreateFileResponse(long fileID) {
            this.fileID = fileID;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "3.0.0.0")]
    [System.ServiceModel.MessageContractAttribute(WrapperName="UploadRequest", WrapperNamespace="http://transfer.diomedestorage.com", IsWrapped=true)]
    public partial class UploadRequest {
        
        [System.ServiceModel.MessageHeaderAttribute(Namespace="http://transfer.diomedestorage.com")]
        public string sessionToken;
        
        [System.ServiceModel.MessageHeaderAttribute(Namespace="http://transfer.diomedestorage.com")]
        public darrenjohnstone.net.FileUpload.DioTransfer.UploadInfo uploadInfo;
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://transfer.diomedestorage.com", Order=0)]
        public System.IO.Stream content;
        
        public UploadRequest() {
        }
        
        public UploadRequest(string sessionToken, darrenjohnstone.net.FileUpload.DioTransfer.UploadInfo uploadInfo, System.IO.Stream content) {
            this.sessionToken = sessionToken;
            this.uploadInfo = uploadInfo;
            this.content = content;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "3.0.0.0")]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class UploadResponse {
        
        public UploadResponse() {
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "3.0.0.0")]
    public interface IDiomedeStorageTransferChannel : darrenjohnstone.net.FileUpload.DioTransfer.IDiomedeStorageTransfer, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "3.0.0.0")]
    public partial class DiomedeStorageTransferClient : System.ServiceModel.ClientBase<darrenjohnstone.net.FileUpload.DioTransfer.IDiomedeStorageTransfer>, darrenjohnstone.net.FileUpload.DioTransfer.IDiomedeStorageTransfer {
        
        public DiomedeStorageTransferClient() {
        }
        
        public DiomedeStorageTransferClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public DiomedeStorageTransferClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public DiomedeStorageTransferClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public DiomedeStorageTransferClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        darrenjohnstone.net.FileUpload.DioTransfer.UploadWithCreateFileResponse darrenjohnstone.net.FileUpload.DioTransfer.IDiomedeStorageTransfer.UploadWithCreateFile(darrenjohnstone.net.FileUpload.DioTransfer.UploadWithCreateFileRequest request) {
            return base.Channel.UploadWithCreateFile(request);
        }
        
        public long UploadWithCreateFile(string sessionToken, darrenjohnstone.net.FileUpload.DioTransfer.UploadWithCreateFileInfo uploadWithCreateFileInfo, System.IO.Stream content) {
            darrenjohnstone.net.FileUpload.DioTransfer.UploadWithCreateFileRequest inValue = new darrenjohnstone.net.FileUpload.DioTransfer.UploadWithCreateFileRequest();
            inValue.sessionToken = sessionToken;
            inValue.uploadWithCreateFileInfo = uploadWithCreateFileInfo;
            inValue.content = content;
            darrenjohnstone.net.FileUpload.DioTransfer.UploadWithCreateFileResponse retVal = ((darrenjohnstone.net.FileUpload.DioTransfer.IDiomedeStorageTransfer)(this)).UploadWithCreateFile(inValue);
            return retVal.fileID;
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        darrenjohnstone.net.FileUpload.DioTransfer.CreateFileResponse darrenjohnstone.net.FileUpload.DioTransfer.IDiomedeStorageTransfer.CreateFile(darrenjohnstone.net.FileUpload.DioTransfer.CreateFileRequest request) {
            return base.Channel.CreateFile(request);
        }
        
        public long CreateFile(string sessionToken, string fileName, string callbackAddress, string hash) {
            darrenjohnstone.net.FileUpload.DioTransfer.CreateFileRequest inValue = new darrenjohnstone.net.FileUpload.DioTransfer.CreateFileRequest();
            inValue.sessionToken = sessionToken;
            inValue.fileName = fileName;
            inValue.callbackAddress = callbackAddress;
            inValue.hash = hash;
            darrenjohnstone.net.FileUpload.DioTransfer.CreateFileResponse retVal = ((darrenjohnstone.net.FileUpload.DioTransfer.IDiomedeStorageTransfer)(this)).CreateFile(inValue);
            return retVal.fileID;
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        darrenjohnstone.net.FileUpload.DioTransfer.UploadResponse darrenjohnstone.net.FileUpload.DioTransfer.IDiomedeStorageTransfer.Upload(darrenjohnstone.net.FileUpload.DioTransfer.UploadRequest request) {
            return base.Channel.Upload(request);
        }
        
        public void Upload(string sessionToken, darrenjohnstone.net.FileUpload.DioTransfer.UploadInfo uploadInfo, System.IO.Stream content) {
            darrenjohnstone.net.FileUpload.DioTransfer.UploadRequest inValue = new darrenjohnstone.net.FileUpload.DioTransfer.UploadRequest();
            inValue.sessionToken = sessionToken;
            inValue.uploadInfo = uploadInfo;
            inValue.content = content;
            darrenjohnstone.net.FileUpload.DioTransfer.UploadResponse retVal = ((darrenjohnstone.net.FileUpload.DioTransfer.IDiomedeStorageTransfer)(this)).Upload(inValue);
        }
    }
}

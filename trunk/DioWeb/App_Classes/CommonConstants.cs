//********************************************************************
// 
//  file:  CommonConstants.cs
// 
//  (C) Copyright 2010, Diomede Corporation
//  All rights reserved
// 
//  Use, modification, and distribution is subject to   
//  the New BSD License (See accompanying file license.txt).
// 
//********************************************************************

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DioWeb.App_Classes
{
    public class CommonConstants
    {
        public const string COOKIE_SETTINGS_PREFIX = "dioweb_set_";
        public const string COOKIE_SETTINGS_PAGESIZE_KEY = "pagesize";
        public const string COOKIE_SETTINGS_OFFSET_KEY = "offset";
        public const string COOKIE_SETTINGS_PAGESIZEUI_KEY = "pagesizeui";

        public const long DEFAULT_OFFSET = 0;
        public const long DEFAULT_PAGE_SIZE = 500;
        public const long DEFAULT_TOTAL_RESULTS = -1;

        public const string LOGIN_MESSAGE_KEY = "msg";
        public const string LOGIN_MESSAGE_SESSION_EXPIRED_VALUE = "expired";
        public const string LOGIN_MESSAGE_INVALID_SESSION = "invalid";
        public const string LOGIN_MESSAGE_USER_CREATED_VALUE = "created";
        public const string LOGIN_MESSAGE_USER_DELETED_VALUE = "deleted";
        public const string LOGIN_MESSAGE_FORGOT_PASSWORD_VALUE = "newpass";

        public const string SESSION_USERNAME_KEY = "username";

        public const string EXCEPTION_SESSION_EXPIRED = "Session expired.";
        public const string EXCEPTION_INVALID_SESSION = "Invalid session.";
        public const string EXCEPTION_USER_NO_LONGER_EXISTS = "The user no longer exists.";
        public const string EXCEPTION_DOWN_FOR_MAINTENANCE = "The server is temporarily down for maintenance.  Please try again later.";

        public const string DEFAULT_METADATA_OBJECT_SFP = "SourceFullPath";
    }
}

//********************************************************************
// 
//  file:  StringHelper.cs
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
    public class StringHelper
    {
        private static readonly long kilobyte = 1024;
        private static readonly long megabyte = 1024 * kilobyte;
        private static readonly long gigabyte = 1024 * megabyte;
        private static readonly long terabyte = 1024 * gigabyte;
        private static readonly long petabyte = 1024 * terabyte;

        private static readonly long kilobyteUI = 1000;
        private static readonly long megabyteUI = kilobyteUI * kilobyte;
        private static readonly long gigabyteUI = megabyteUI * kilobyte;
        private static readonly long terabyteUI = gigabyteUI * kilobyte;
        private static readonly long petabyteUI = terabyteUI * kilobyte;
        
        public static string ToByteString(double bytes)
        {
            if (bytes >= petabyteUI) return (bytes / (double)petabyte).ToString("0.00 PB");
            else if (bytes >= terabyteUI) return (bytes / (double)terabyte).ToString("0.00 TB");
            else if (bytes >= gigabyteUI) return (bytes / (double)gigabyte).ToString("0.00 GB");
            else if (bytes >= megabyteUI) return (bytes / (double)megabyte).ToString("0.00 MB");
            else if (bytes >= kilobyteUI) return (bytes / (double)kilobyte).ToString("0.00 KB");
            else return bytes + " B";
        }

        public static string ToMoneyString(int i)
        {
            return ((double)i / 10000).ToString("$#,0.0000");
        }

        public static bool IsLoginExceptionString(string ex)
        {
            bool retVal = false;
            if (ex.Equals(CommonConstants.EXCEPTION_SESSION_EXPIRED) ||
                ex.Equals(CommonConstants.EXCEPTION_INVALID_SESSION) ||
                ex.Equals(CommonConstants.EXCEPTION_USER_NO_LONGER_EXISTS) ||
                ex.Equals(CommonConstants.EXCEPTION_DOWN_FOR_MAINTENANCE))
            {
                retVal = true;
            }
            return retVal;
        }

        public static bool IsSessionExceptionString(string ex)
        {
            bool retVal = false;
            if (ex.Equals(CommonConstants.EXCEPTION_SESSION_EXPIRED) ||
                ex.Equals(CommonConstants.EXCEPTION_INVALID_SESSION))
            {
                retVal = true;
            }
            return retVal;
        }
    }
}

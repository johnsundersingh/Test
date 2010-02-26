//********************************************************************
// 
//  file:  FileHelper.cs
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
using System.IO;
using System.Security.Cryptography;

namespace DioWeb.App_Classes
{
    public class FileHelper
    {
        public static string GetMD5(Stream data)
        {
            byte[] output = MD5.Create().ComputeHash(data);

            string hashValue = string.Empty;
            foreach (byte hex in output)
            {
                hashValue += hex.ToString("x2").ToUpper();
            }
            return hashValue;
        }
    }
}

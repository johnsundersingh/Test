//********************************************************************
// 
//  file:  CookieHelper.cs
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
    public class CookieHelper
    {
        public static string GetValue(string cookieName, string key)
        {
            string returnValue = string.Empty;
            HttpCookie cookie = HttpContext.Current.Request.Cookies[cookieName];
            if (cookie != null)
            {
                if (cookie.Values.AllKeys.Contains(key))
                {
                    // URLEnconde instead? http://madskristensen.net/post/Cookies-and-Unicode-characters.aspx
                    returnValue = HttpContext.Current.Server.HtmlEncode(cookie[key]);
                }
            }
            return returnValue;
        }

        public static void SetValue(string cookieName, string key, string value)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[cookieName];
            if (cookie == null)
            {
                cookie = new HttpCookie(cookieName);
            }
            cookie.Values[key] = value;
            cookie.Expires = DateTime.Now.AddYears(10);
            HttpContext.Current.Response.Cookies.Add(cookie);
        }

        public static void SetValue(string cookieName, string key, string value, DateTime expires)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[cookieName];
            if (cookie == null)
            {
                cookie = new HttpCookie(cookieName);
            }
            cookie.Values[key] = value;
            cookie.Expires = expires;
            HttpContext.Current.Response.Cookies.Add(cookie);
        }
    }
}
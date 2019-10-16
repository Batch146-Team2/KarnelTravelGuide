using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Source.Models
{
    public class Mysecurity
    {
        public static string EncryptString(string str)
        {
            SHA256 sha = SHA256Managed.Create();
            byte[] data = Encoding.UTF8.GetBytes(str);
            byte[] result = sha.ComputeHash(data);
            return BitConverter.ToString(result).ToLower().Replace("-", "");
        }
    }
}
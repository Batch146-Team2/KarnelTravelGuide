using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Source.Areas.Admin.Models
{
    //Working
    public enum TypeControl : byte
    {
        AddNew=1,
        Edit=2,
        Delete=4,
        View=8
    }
}
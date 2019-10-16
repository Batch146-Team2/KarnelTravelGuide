using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Source.Areas.Admin.Models
{
    public class Untils
    {
        //To check permission equal with value in the Typecontrol
        //Example : 9 = 1001 = 1000 + 0001 = 8 + 1= View + AddNew

        //Working

        public static bool HasPermission(TypeControl control,int permission)
        {
            if (((int)control & permission) == (int)control)
            {
                return true;
            }
            return false;
        }
    }
}
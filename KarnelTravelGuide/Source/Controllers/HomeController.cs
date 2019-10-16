using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Source.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult Contact()
        {
            return View();
        }
        public ActionResult LoginRedirect(string returnUrl)
        {
            string[] urls = returnUrl.Split('/');
            switch (urls[1])
            {
                case "Admin"://area name
                    return Redirect("/Admin/Account/Login");
                default:
                    return Redirect("/Customer/Login");
            }
        }
    }
}
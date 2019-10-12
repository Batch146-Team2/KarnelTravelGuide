using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Source.Models;

namespace Source.Areas.Admin.Controllers
{
    public class AccountController : Controller
    {
        KarnelTravelEntities db = new KarnelTravelEntities();
        // GET: Admin/Account
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(string username, string password)
        {
            var emp = db.Employees.Where(x => x.LoginName.Equals(username) && x.Password.Equals(password)).SingleOrDefault();
            if (emp != null)
            {
                FormsAuthentication.SetAuthCookie(emp.Id.ToString(), false);
                return Redirect("~/Admin");
            }
            else
            {
                ViewBag.Message = "Invalid username or password";
            }
            return View();
        }
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }
    }
}
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
        public ActionResult Login(string username,string password)
        {
            var pw = Mysecurity.EncryptString(password);
            var emp = db.Employees.Where(x => x.LoginName.Equals(username) && x.Password.Equals(pw)).SingleOrDefault();
            if (emp != null)
            {
                FormsAuthentication.SetAuthCookie(emp.Id.ToString(), false);
                Session["avatar"] = emp.Avatar;
                Session["EmployeeName"] = emp.EmployeeName;
                Session["employee"] = emp;
                return Redirect("~/Admin");
                
            }
            else
            {
                ViewBag.Message = "Invalid username or password";
            }
            return View();
        }
        
        public ActionResult Profile()
        {
            int id = int.Parse(User.Identity.Name);
            var emp = db.Employees.Find(id);
            return View(emp);
        }
        [HttpPost]
        public ActionResult Profile(Employee data, HttpPostedFileBase avatar)
        {
            int id = int.Parse(User.Identity.Name);
            var emp = db.Employees.Find(id);
            emp.EmployeeName = data.EmployeeName;
            emp.Phone = data.Phone;
            emp.Address = data.Address;
            emp.Email = data.Email;
            try
            {
                if (avatar != null)
                {
                    string dir = Server.MapPath("\\") + "\\Content\\avatar\\" + id + "\\";
                    if (System.IO.File.Exists(dir + emp.Avatar))
                    {
                        System.IO.File.Delete(dir + emp.Avatar);
                    }

                    string filename = avatar.FileName.Split('\\').Last();

                    if (System.IO.Directory.Exists(dir) == false)
                    {
                        System.IO.Directory.CreateDirectory(dir + data.Id);
                    }
                    avatar.SaveAs(dir + filename);
                    emp.Avatar = filename;
                }
                db.SaveChanges();
                ViewBag.Message = "Ok";
            }
            catch (Exception ex)
            {

                ViewBag.Message = ex.Message;
            }
            return View(emp);

        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }
    }
}
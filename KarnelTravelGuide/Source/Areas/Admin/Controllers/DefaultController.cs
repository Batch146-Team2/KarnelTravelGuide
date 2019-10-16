using Source.Areas.Admin.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Source.Areas.Admin.Controllers
{
    [Authorize]
    public class DefaultController : Controller
    {
        
        // GET: Admin/Default
        public ActionResult Index()
        {
            return View();
        }
    }
}
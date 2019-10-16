using Source.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;

namespace Source.Areas.Admin.Models
{

    //Working

    public class CheckAccessAttribute: AuthorizeAttribute
    {
        //permission 2
        //add controllers
        //[CheckAccess(Role="Admin")]
        //public controller

        private readonly string[] allowedRoles;
        
        public CheckAccessAttribute(params string[] roles)
        {
            this.allowedRoles = roles;
        }
        
        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            IPrincipal user = httpContext.User;
            bool authorize = false;
            if (user.Identity.IsAuthenticated)
            {
                if (allowedRoles.Count()>0)
                {
                    var dbuser = GetUserByName(user.Identity.Name);
                    foreach (string role in allowedRoles)
                    {
                        if (dbuser.EmployeeName.Equals(role))//EmployeeName instance is a role
                        {
                            authorize = true;
                        }
                    }
                }
                else authorize = true;
            }
            return authorize;
        }
        public Employee GetUserByName(string username)
        {
            KarnelTravelEntities db = new KarnelTravelEntities();
            return db.Employees.Where(x=>x.LoginName.Equals(username)).SingleOrDefault();
        }
        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            if (filterContext.HttpContext.User.Identity.IsAuthenticated)
            {
                filterContext.Result = new ViewResult { ViewName = "UnAuthorize" };////Finally, add to view UnAuthorize in the Shared
            }
            else
            {
                filterContext.Result = new HttpUnauthorizedResult();
            }
            
        }

















        //permission 1
        public string View { get; set; }
        public CheckAccessAttribute()
        {
            View = "AuthorizeFailed";//Finally, add to view AuthorizeFailde in the Shared
        }
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            base.OnAuthorization(filterContext);
            IsUserAuthorized(filterContext);
        }
        private void IsUserAuthorized(AuthorizationContext filterContext)
        {
            // If the Result returns null then the user is Authorized 
            if (filterContext.Result == null)
                return;

            //If the user is Un-Authorized then Navigate to Auth Failed View 
            if (filterContext.HttpContext.User.Identity.IsAuthenticated)

            {
                var vr = new ViewResult();
                vr.ViewName = View;

                ViewDataDictionary dict = new ViewDataDictionary();
                dict.Add("Message", "Sorry you are not Authorized to Perform this Action");
                vr.ViewData = dict;

                var result = vr;
                filterContext.Result = vr;
            }
        }
    }
}
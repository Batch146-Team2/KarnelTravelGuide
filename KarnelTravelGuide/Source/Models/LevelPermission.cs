//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Source.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class LevelPermission
    {
        public int Id { get; set; }
        public int LevelId { get; set; }
        public string TableName { get; set; }
        public string DisplayName { get; set; }
        public bool AllowPermission { get; set; }
    
        public virtual Level Level { get; set; }
    }
}

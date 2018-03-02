using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Automata.WebApi.HelpPage
{
    public class ApiDisplayAttribute: Attribute
    {
        public int Order { get; set; }

        private bool? _isNew;

        public bool IsNew {
            get {
                if (_isNew.HasValue)
                {
                    return _isNew.Value;
                }
                return DateTime.Now.AddDays(-15) < CreateTime;
            }
            set {
                _isNew = value;
            }
        }

        public bool IsHot { get; set; }

        public DateTime CreateTime{get;set;}
    }
}

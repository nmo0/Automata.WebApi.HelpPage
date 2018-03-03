using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace $rootnamespace$.Areas.HelpPage.Models
{
    public class HelpPageAppConfig
    {
        static HelpPageAppConfig()
        {
            Site = new EnvironmentSite();
        }

        public static EnvironmentSite Site { get; set; }
    }

    public class EnvironmentSite
    {
        public string TEST { get; set; }
        public string UAT { get; set; }
        public string PROD { get; set; }
    }
}

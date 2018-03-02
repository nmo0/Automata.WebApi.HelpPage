using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace $rootnamespace$.Areas.HelpPage.Models
{
    public class ColorAttribute: Attribute
    {
        public string Color { get; set; }
        public ColorAttribute(string color)
        {
            Color = color;
        }
    }
}
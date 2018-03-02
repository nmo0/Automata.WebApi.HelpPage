using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Automata.WebApi.HelpPage
{
    public class SampleAttribute : Attribute
    {
        public object Sample { get; set; }
    }

    public class IsSimple
    {
        public bool Simple { get; set; }
    }
}

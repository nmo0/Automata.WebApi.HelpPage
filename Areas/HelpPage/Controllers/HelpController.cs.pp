using System;
using System.Web.Http;
using System.Web.Mvc;
using $rootnamespace$.Areas.HelpPage.ModelDescriptions;
using $rootnamespace$.Areas.HelpPage.Models;
using System.Reflection;
using System.Linq;
using System.ComponentModel;
using System.IO;
using Newtonsoft.Json.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.Text;

namespace $rootnamespace$.Areas.HelpPage.Controllers
{
    /// <summary>
    /// The controller that will handle requests for the help page.
    /// </summary>
    public class HelpController : Controller
    {
        private const string ErrorViewName = "Error";

        public HelpController()
            : this(GlobalConfiguration.Configuration)
        {
        }

        public HelpController(HttpConfiguration config)
        {
            Configuration = config;
        }

        public HttpConfiguration Configuration { get; private set; }


        public ActionResult Index()
        {
            ViewBag.DocumentationProvider = Configuration.Services.GetDocumentationProvider();

            return View(Configuration.Services.GetApiExplorer().ApiDescriptions);
        }

        public ActionResult Api(string apiId)
        {
            if (!String.IsNullOrEmpty(apiId))
            {
                HelpPageApiModel apiModel = Configuration.GetHelpPageApiModel(apiId);
                if (apiModel != null)
                {
                    if (apiModel.ResourceDescription != null)
                    {
                        var modelResult = (ComplexTypeModelDescription)apiModel.ResourceDescription;
                        var paramsList = modelResult.Properties;
                        foreach (var v in paramsList)
                        {
                            if (string.IsNullOrEmpty(v.Documentation))
                            {
                                if (v.Name == "Code")
                                {
                                    v.Documentation = "0成功，1失败";
                                    continue;
                                }
                                if (v.Name == "Data")
                                {
                                    v.Documentation = "返回数据";
                                    continue;
                                }
                                if (v.Name == "Msg")
                                {
                                    v.Documentation = "返回信息";
                                    continue;
                                }
                            }
                        }
                    }

                    return View(apiModel);
                }
            }

            return View(ErrorViewName);
        }

        public ActionResult ResourceModel(string modelName)
        {
            if (!String.IsNullOrEmpty(modelName))
            {
                ModelDescriptionGenerator modelDescriptionGenerator = Configuration.GetModelDescriptionGenerator();
                ModelDescription modelDescription;
                if (modelDescriptionGenerator.GeneratedModels.TryGetValue(modelName, out modelDescription))
                {
                    if (modelDescription != null)
                    {
                        //{$rootnamespace$.Areas.HelpPage.ModelDescriptions.ComplexTypeModelDescription}

                        var modelResult = (ComplexTypeModelDescription)modelDescription;


                        var FullName = modelDescription.ModelType.FullName;
                        //Assembly.Load("ServiceModel");

                        Assembly ass = Assembly.Load(modelDescription.ModelType.Assembly.FullName);
                        Type t = ass.GetType(modelDescription.ModelType.FullName);   //参数必须是类的全名
                        PropertyInfo[] pis = t.GetProperties();

                        var paramsList = modelResult.Properties;
                        foreach (var v in paramsList)
                        {
                            if (string.IsNullOrEmpty(v.Documentation))
                            {
                                foreach (PropertyInfo pi in pis)
                                {
                                    if (v.Name == pi.Name)
                                    {
                                        object[] objs = pi.GetCustomAttributes(typeof(DescriptionAttribute), true);
                                        if (objs.Length > 0)
                                        {
                                            DescriptionAttribute att = objs[0] as DescriptionAttribute;
                                            v.Documentation = att.Description;
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    return View(modelDescription);
                }
            }

            return View(ErrorViewName);
        }

    }
}
using System.Reflection;
 using System.Runtime.InteropServices;
 
 namespace Sample.Web.Api.Models
 {
     public class HealthStatus
     {
         public string Version
         {
             get
             {
                 return typeof(HealthStatus)
                         .GetTypeInfo().Assembly
                         .GetCustomAttribute<AssemblyFileVersionAttribute>()
                         .Version;
             }
         }
     }
 }
using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Logixion.Admin.Startup))]
namespace Logixion.Admin
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

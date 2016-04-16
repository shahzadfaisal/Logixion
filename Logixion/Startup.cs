using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Logixion.Startup))]
namespace Logixion
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

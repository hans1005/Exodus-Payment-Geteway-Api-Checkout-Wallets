using Exodus.API.Models;
using Exodus.DTO_Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Exodus.API.Controllers
{
    public class WrapperController : BaseApiController
    {
        public API_Response<Dictionary<string, object>> ConcatActions([FromBody] Dictionary<string, object> model, [FromUri] string api_key = null)
        {
            return InvokeAPI(() =>
            {
                return new Dictionary<string, object>();
            }, api_key);
        }
    }
}

using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;

namespace Goyotek.Serverless.Azure
{
    public static class Broadcaster
    {
        [FunctionName("Broadcaster")]
        public static void Run([TimerTrigger("0 */5 * * * *")] TimerInfo myTimer, ILogger log)
        {
            log.LogInformation($"C# Timer trigger function executed at: {DateTime.Now}");
        }
    }
}

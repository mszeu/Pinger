# Pinger
**Pinger** is a simple PowerShell script that pings the specified list of hosts at regular intervals for a specified time.

If the time specified through the parameter **Seconds** is zero that the script never terminates and CTRL-C is needed to terminate it.

It is possible to specify the delay between the pings using the optional parameter **Delay**. 

If **Delay** is not specified, the default value is **160** seconds.

The script is given **AS IS** and it is under the **AGPL Aferro license 3.0**.

For more information about the license terms please refer tot the **LICENSE** file distributed with the project.
## Usage

**\Pinger.ps1** **Ip1**,**Ip2**,...,**Ipn** [**-Delay** seconds] [**-Seconds** seconds]
- **Ip1**,**Ip2**,...,**Ipn**: the list of coma-separated addresses to ping (e.g.: *10.0.0.1,10.0.0.2,10.0.0.10*)
  
  Optionally, you can add a description using this format: IP:Description. Example: 10.0.0.1:server1,10.0.0.3:serverTwo,.. etc.
- **-Delay**: the delay in seconds between one ping operation and the other one. If it is not specified, the default is 160 seconds
- **-Seconds**: for how long to do execute the program. If it is not specified, or if zero is specified it will execute for ever.

## Example

**.\Pinger.ps1** "192.168.51.10:ServerX","192.168.51.30:HSMPED01","192.168.51.50","192.168.51.70:MACOSSrv","192.168.51.90" **-Seconds** 0 **-Delay** 15

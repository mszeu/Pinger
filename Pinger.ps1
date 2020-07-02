<#
    .SYNOPSIS
    Pings a comma separated list of addresses for a certain time with a specified interval.
    .DESCRIPTION
     Pings a comma separated list of addresses for a specified time with a specified interval frequency.
     The times are specified through the parameters -Delay and -Seconds are expressed in seconds.
     If the parameter -Seconds is omitted or set to zero the script runs continuously.
     .PARAMETER IpList
     A comma separated list of hosts or IPs
     .PARAMETER Delay
     The interfal between Pings. It is expressed in seconds and if is not specified it defalts to 160 seconds
    .PARAMETER Seconds
     It detemines for how long the program runs. It is expressed in seconds and it is not specified, or set to zero, the program never terminates
    .EXAMPLE
     Pinger 10.0.0.1,10.0.0.2,10.0.0.10 -Delay 30 -Seconds 300
    .NOTES
      Author: Marco S. Zuppone - msz@msz.eu
      Version: 1.1
      License: AGPL 3.0 - Plese abide to the Aferro AGPL 3.0 license rules! It's free bug give credit to the authors :-)
      
#>
param (
        [Parameter(Mandatory)]
        $AddrIPs,
        [int]$Delay=160,
        [int]$Seconds=0
        
)
Write-Host $Delay

$StartTime=Get-Date

Do {
    Get-Date
    $Exit = $False
    foreach ($AddrIP in $AddrIPs) {
        
        $Pingo = Get-WmiObject Win32_PingStatus -f "Address='$AddrIP'" 
        $Pingo | Format-Table Address, ResponseTime, StatusCode -auto

    }
    Start-Sleep -seconds $Delay
    if ($Seconds -ne 0){
        $timeNow = Get-Date

        If ( $timeNow -ge $StartTime.AddSeconds($Seconds)) 
             {
                 $Exit=$True 
                }
    }    
}
    until ($Exit)
    
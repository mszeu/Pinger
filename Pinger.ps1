<#
    .SYNOPSIS
     Pings a comma separated list of addresses for a certain time with a specified interval.
    .DESCRIPTION
     Pings a comma separated list of addresses for a specified time with a specified interval frequency.
     The times are specified through the parameters -Delay and -Seconds. They are expressed in seconds.
     If the parameter -Seconds is omitted or set to zero the script runs continuously.
     .PARAMETER IpList
     A comma separated list of hosts or IPs
     .PARAMETER Delay
     The interval between Pings. It is expressed in seconds and, if is not specified, it defaults to 160 seconds.
    .PARAMETER Seconds
     It determines for how long the program runs. It is expressed in seconds and if it is not specified, or set to zero, the program never terminates.
    .EXAMPLE
     Pinger 10.0.0.1,10.0.0.2,10.0.0.10 -Delay 30 -Seconds 300
    .NOTES
      Author: Marco S. Zuppone - msz@msz.eu - https://msz.eu
      Version: 1.2.1
      License: AGPL 3.0 - Please abide to the Affero AGPL 3.0 license rules! It's free but give credits to the author :-)
      For donations: https://buymeacoffee.com/readitalians
      Test
      
#>
param (
    [Parameter(Mandatory)]
    $AddrIPs,
    [int]$Delay = 160,
    [int]$Seconds = 0
        
)
Write-Host $Delay

$StartTime = Get-Date

Do {
    Get-Date
    $Exit = $False
    $Results = @()
    foreach ($AddrIP in $AddrIPs) {
        
        $Pingo = Get-WmiObject Win32_PingStatus -f "Address='$AddrIP'"
        
        switch ($Pingo.StatusCode) {
            0 { $ResultMessage = "Success"; break }						
            11001 { $ResultMessage = "Buffer Too Small"; break }				
            11002 { $ResultMessage = "Destination Net Unreachable"; break } 	
            11003 { $ResultMessage = "Destination Host Unreachable" ; break }	
            11004 { $ResultMessage = "Destination Protocol Unreachable"; break }
            11005 { $ResultMessage = "Destination Port Unreachable" ; break }	
            11006 { $ResultMessage = "No Resources" 	; break }				
            11007 { $ResultMessage = "Bad Option"	; break }					
            11008 { $ResultMessage = "Hardware Error" ; break }					
            11009 { $ResultMessage = "Packet Too Big" 	; break }				
            11010 { $ResultMessage = "Request Timed Out" ; break }				
            11011 { $ResultMessage = "Bad Request" 	; break }				
            11012 { $ResultMessage = "Bad Route"		; break }				
            11013 { $ResultMessage = "TimeToLive Expired Transit" ; break }		
            11014 { $ResultMessage = "TimeToLive Expired Reassembly" ; break }	
            11015 { $ResultMessage = "Parameter Problem" 	; break }			
            11016 { $ResultMessage = "Source Quench" 	; break }				
            11017 { $ResultMessage = "Option Too Big" 	; break }				
            11018 { $ResultMessage = "Bad Destination" 	; break }			
            11032 { $ResultMessage = "Negotiating IPSEC" ; break }				
            11050 { $ResultMessage = "General Failure" 	; break }
            Default { $ResultMessage = "Unknown Error" }			
        }

        $Results += @([pscustomobject]@{
                Address      = $Pingo.Address; 
                ResponseTime = $Pingo.ResponseTime;
                StatusCode   = $Pingo.StatusCode;
                Message      = $ResultMessage; 
                TimeStamp    = Get-Date 
            })

    }
    $Results | Format-Table Address,
                            @{L = "Response Time"; E = { $_.ResponseTime } },
                            @{L = "Status Code"; E = { $_.StatusCode } },
                            Message,
                            @{L = "Timestamp"; E = { $_.TimeStamp } } -AutoSize 
    Write-Host "Waiting for $Delay seconds..."
    Write-Host "Next Ping cycle will start at "(Get-Date).AddSeconds($Delay)
    Start-Sleep -seconds $Delay
    if ($Seconds -ne 0) {
        $timeNow = Get-Date

        If ( $timeNow -ge $StartTime.AddSeconds($Seconds)) {
            $Exit = $True 
        }
    }    
}
until ($Exit)
    
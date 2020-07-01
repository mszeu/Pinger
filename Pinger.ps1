
param (
        [Parameter(Mandatory)]
        $AddrIPs,
        $Delay=160,
        $Seconds=0
        
)
Write-Host $Delay

$StartTime=Get-Date

Do {
    Get-Date
    $Exit = $False
    foreach ($AddrIP in $AddrIPs) {
        
        $Pingo = Get-WmiObject Win32_PingStatus -f "Address='$AddrIP'" 
        $Pingo | Format-Table Address, StatusCode -auto
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




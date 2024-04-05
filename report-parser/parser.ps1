param(
    [Parameter(Mandatory=$true)][string]$path,
    [switch]$show_all=$false,
    [switch]$exploits=$false
)

[xml]$xml=Get-Content -Path $path

$vulners=@()
$data=$xml.nmaprun.host | ForEach-Object {
    $ip = $_.address.addr
    $_.ports.port | Where-Object { $_.script.id -eq 'vulners' } | ForEach-Object {
        $port=$_.portid
        $protocol=$_.protocol
        $_.script.table | ForEach-Object {
            $service=$_.key -replace "cpe:/",""
            $_.table | ForEach-Object {
                $keys=@{}
                $_.elem | Where-Object { $_ -and $_.key } | ForEach-Object {
                    $keys[$_.key]=$_.'#text'
                }
                if($keys.Count -gt 0){
                    $vulners+=[PSCustomObject]@{
                        ip = $ip
                        port = $port
                        protocol = $protocol
                        cpe = $service
                        cve = $keys['id']
                        type = $keys['type']
                        exploit = $keys['is_exploit'] -eq 'true'
                        cvss = $keys['cvss']
                        url = "http://vulners.com/"+$keys['type']+"/"+$keys['id']
                    }
                }
            }
        }
    }

    [PSCustomObject]@{
        ip      =   $_.address.addr
        ports   =   ($_.ports.port | Where-Object { $_.state.state -eq 'open' } | ForEach-Object { $_.portid }) -join ", "
    }
} | Select-Object -Property ip,ports | Where-Object {
    $show_all -or $_.ports
} | Sort-Object {
    [System.Version]$_.ip
} -Unique 
$data | Format-Table
$data | Export-CSV "ports.csv" -Delimiter ";" -Encoding utf8 -NoTypeInformation

$vulners | Export-CSV "vulners.csv" -Delimiter ";" -Encoding utf8 -NoTypeInformation

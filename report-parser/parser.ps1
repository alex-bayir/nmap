param(
    [Parameter(Mandatory=$true)][string]$data,
    [Parameter(Mandatory=$false)][switch]$hide_with_closed=$false
)

filter opened {
	if($_.state.state -eq 'open'){
		$_
	}
}

[xml]$xml=Get-Content -Path $data
$xml.nmaprun.host | ForEach-Object {
    [PSCustomObject]@{
        ip      =   $_.address.addr
        ports   =   ($_.ports.port | opened | ForEach-Object { $_.portid }) -join ", "
    }
} | Select-Object -Property ip,ports | Where-Object {
    $hide_with_closed -and ($_.ports -ne '')
} | Sort-Object {
    [System.Version]$_.ip
} | Format-Table


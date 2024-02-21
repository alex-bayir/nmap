param(
    [Parameter(Mandatory=$true)][String]$data
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
} | Select-Object -Property ip,ports | Sort-Object {[System.Version]$_.ip}  | Format-Table


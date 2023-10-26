param (
	[Parameter(Mandatory=$true)]
	[string]$COMn,
	[Parameter(Mandatory=$true)]
	[string]$Baud,
	[Parameter(Mandatory=$true)]
	[string]$Parity
)


try {
	$port = new-Object System.IO.Ports.SerialPort $COMn,$Baud,$Parity,8,one
	$port.open()
	$timeout = New-TimeSpan -Seconds 10
	$sw = [Diagnostics.Stopwatch]::StartNew()
	while ($sw.elapsed -lt $timeout) {
		$data = $port.ReadExisting()

		if ($data) {
			Write-Host -NoNewLine $data
		}
	}
	Write-Host "Stop watch completed"
}
finally {
	Write-Host "Closing ports"
	$sw.Stop()
	$port.Close()
}

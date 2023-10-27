param (
	[Parameter(Mandatory=$true, HelpMessage="COMn (e.g COM1 | COM2 | ...)")]
	[string]$COMn,
	[Parameter(Mandatory=$true, HelpMessage="Baudrate (9600 | 19200 | ...)")]
	[string]$Baud,
	[Parameter(Mandatory=$true, HelpMessage="Parity (none | even | odd | mark | space)")]
	[string]$Parity
)

try {
	$port = new-Object System.IO.Ports.SerialPort $COMn,$Baud,$Parity,8,one
	Write-Host "Opening serial port. Press <C-c> to exit..."
	$port.open()
	while ($true) {
		$data = $port.ReadExisting()

		if ($data) {
			Write-Host -NoNewLine $data
		}
	}
} finally {
	$port.Close()
}

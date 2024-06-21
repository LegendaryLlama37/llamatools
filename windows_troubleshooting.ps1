# Define paths and variables
$csvPath = "C:\path\to\machines.csv"
$logPath = "C:\path\to\network_test_logs.txt"
$port = 80  # Port number to test connectivity (adjust as needed)

# Function to test connectivity and log results
function Test-Connectivity {
    param($hostname)

    # Get current timestamp
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Attempt ping
    $pingResult = Test-Connection -ComputerName $hostname -Count 1 -Quiet

    if ($pingResult) {
        # Ping successful, attempt to connect to port
        try {
            $tcpClient = New-Object System.Net.Sockets.TcpClient
            $tcpClient.Connect($hostname, $port)
            $tcpClient.Close()
            Write-Output "$timestamp - $hostname: Connection successful"
            Add-Content -Path $logPath -Value "$timestamp - $hostname: Connection successful"
        }
        catch {
            # Connection failed
            Write-Output "$timestamp - $hostname: Firewall issue or unreachable (Error: $_)"
            Add-Content -Path $logPath -Value "$timestamp - $hostname: Firewall issue or unreachable (Error: $_)"
        }
    }
    else {
        # Ping failed, could be authentication issue or host unreachable
        Write-Output "$timestamp - $hostname: Authentication issue or host unreachable"
        Add-Content -Path $logPath -Value "$timestamp - $hostname: Authentication issue or host unreachable"
    }
}

# Read CSV file
$hosts = Import-Csv -Path $csvPath

# Loop through each hostname and test connectivity
foreach ($host in $hosts) {
    Test-Connectivity -hostname $host.Hostname
}

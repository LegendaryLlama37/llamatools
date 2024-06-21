package main
// first itteration
import (
    "fmt"
    "os"
    "os/exec"
)

func main() {
    // Define PowerShell script path and parameters
    scriptPath := "C:\\path\\to\\network_test.ps1"
    csvPath := "C:\\path\\to\\machines.csv"
    logPath := "C:\\path\\to\\network_test_logs.txt"
    port := "80"

    // Construct PowerShell command
    args := []string{"-ExecutionPolicy", "Bypass", "-File", scriptPath, "-csvPath", csvPath, "-logPath", logPath, "-port", port}
    cmd := exec.Command("powershell.exe", args...)

    // Execute PowerShell script
    output, err := cmd.CombinedOutput()
    if err != nil {
        fmt.Println("Error executing PowerShell script:", err)
        return
    }

    // Print PowerShell script output
    fmt.Println("PowerShell script output:")
    fmt.Println(string(output))
}

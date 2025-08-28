# PowerShell script to check Unix job status using Paramiko
# Loads credentials from .env in current folder

# Load .env file
$envFile = Join-Path $PSScriptRoot ".env"
$envVars = Get-Content $envFile
foreach ($line in $envVars) {
    $trimmed = $line.Trim()
    if ($trimmed -eq "" -or $trimmed.StartsWith("#") -or $trimmed -notmatch "^[A-Z0-9_]+=.+$") {
        Write-Host "Skipping line: $line"
        continue
    }
    $parts = $trimmed -split "="
    if ($parts.Length -eq 2 -and $parts[0].Trim() -match "^[A-Z0-9_]+$" -and $parts[1].Trim() -ne "") {
        Write-Host "Setting env: $($parts[0].Trim()) = $($parts[1].Trim())"
        $name = $parts[0].Trim()
        $value = $parts[1].Trim()
        if ($name -match "^[A-Z0-9_]+$") {
            Set-Item -Path "Env:$name" -Value $value
        }
    } else {
        Write-Host "Invalid env line: $line"
    }
}

$sshHost = $env:SSH_HOST
$sshUser = $env:SSH_USER
$sshKeyPath = $env:SSH_KEY_PATH
$remoteScript = $env:REMOTE_SCRIPT_PATH

# Use Python/Paramiko for SSH (requires python, paramiko)
$pythonScript = @"
import os
import paramiko
ssh_host = os.environ['SSH_HOST']
ssh_user = os.environ['SSH_USER']
ssh_key_path = os.environ['SSH_KEY_PATH']
remote_script = os.environ['REMOTE_SCRIPT_PATH']

key = paramiko.RSAKey.from_private_key_file(ssh_key_path)
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(ssh_host, username=ssh_user, pkey=key)
stdin, stdout, stderr = ssh.exec_command(f"bash {remote_script}")
output = stdout.read().decode()
error = stderr.read().decode()
ssh.close()

print("===JOB STATUS OUTPUT===")
print(output)
if error:
    print("===ERROR===")
    print(error)
"@

$pyFile = Join-Path $PSScriptRoot "_run_unix_job_status.py"
Set-Content -Path $pyFile -Value $pythonScript

python $pyFile

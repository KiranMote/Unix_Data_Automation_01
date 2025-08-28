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

import os
import subprocess


home = os.path.expanduser("~")

def run_command(command: list | str, shell: bool = False) -> None:
    """
    Run a shell command
    """
    subprocess.run(command, shell=shell)

def yay_install(packages: list) -> None:
    """
    Install packages from AUR
    """
    if packages:
        subprocess.run(["yay", "-S", "--noconfirm"] + packages)

def pacman_install(packages: list) -> None:
    """
    Install pacman packages
    """
    if packages:
        subprocess.run(["sudo", "pacman", "-S", "--noconfirm"] + packages)

def configure() -> None:
    for folder in os.listdir(".config"):
        command = f"cp -r .config/{folder}/* {home}/.config/{folder}"
        run_command(command, shell=True)

    run_command("sudo cp -r .system/sddm/themes/* /usr/share/themes/", shell=True)
    run_command(["sudo", "mkdir", "-p", "/etc/sddm.conf.d"])
    run_command("sudo cp -r .system/sddm/sddm.conf.d/* /etc/sddm.conf.d/", shell=True)
    run_command(["chsh", "-s", "/usr/bin/fish"])

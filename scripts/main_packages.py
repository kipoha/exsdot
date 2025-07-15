import os
import stat
from runner import run_command, yay_install, pacman_install, home


PACMAN_PACKAGES = [
    "kitty",
    "fish",
    "fastfetch",
    "git",
    "firefox",
    "cava",
    "pavucontrol",
    "chromium",
    "hyprlock",
    "hypridle",
    "swww",
    "dunst",
    "wl-clipboard",
    "brightnessctl",
    "cliphist",
    "papirus-icon-theme",
    "libnotify",
    "gobject-introspection",
    "glow",
    "less",
    "ninja",
    "curl",
    "base-devel",

    # file viewer/editor
    "imagemagick",
    "unzip",
    "p7zip",
    "tar",
    "libreoffice-fresh",
    "evince",
    "gimp",
    "mpv",
    "imv",

    "qt5-declarative",
    "qt5-quickcontrols2",
    "qt5-graphicaleffects",
    "xdg-desktop-portal",
    "xdg-desktop-portal-gtk",
    "nwg-look",
]

YAY_PACKAGES = [
    "hyprshot",
    "catppuccin-gtk-theme-mocha",
    "bibata-cursor-theme",
    "walker",
    "appimagelauncher"
]


FONTS = [
    "ttf-jetbrains-mono",
    "ttf-jetbrains-mono-nerd",
    "noto-fonts-cjk",
    "noto-fonts",
    "noto-fonts-extra",
    "noto-fonts-emoji",
]



AUR_SCRIPTS = [
    f"git clone https://aur.archlinux.org/yay.git {home}/yay",
    f"cd {home}/yay",
    "makepkg -si",
    "cd",
    f"rm -rf {home}/yay",
]
def make_install_script_executable():
    path = os.path.join(".config", "Ax-Shell", "install.sh")
    if os.path.isfile(path):
        st = os.stat(path)
        os.chmod(path, st.st_mode | stat.S_IXUSR)
        print(f"{path} сделан исполняемым.")
    else:
        print(f"{path} не найден.")

def install(yay: bool = False, yay_packages: bool = False) -> None:
    print("Installing main packages...")
    pacman_install(PACMAN_PACKAGES)
    pacman_install(FONTS)
    if yay:
        run_command(AUR_SCRIPTS, shell=True)
    if yay_packages:
        yay_install(YAY_PACKAGES)
    make_install_script_executable()
    run_command(["./.config/Ax-Shell/install.sh"])

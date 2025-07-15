from runner import yay_install, pacman_install

PACMAN_PACKAGES = [
    "docker",
    "docker-compose",
    "elixir",
    "uv",
]

YAY_PACKAGES = [
    "python311",
]



def install(yay_packages: bool = False) -> None:
    print("Installing dev packages...")
    pacman_install(PACMAN_PACKAGES)
    if yay_packages:
        yay_install(YAY_PACKAGES)

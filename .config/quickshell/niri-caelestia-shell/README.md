> [!CAUTION]
> This is my personal thingy and it's **STILL WORK IN PROGRESS.**
>
> This repo is **ONLY for the desktop shell** of the caelestia dots, ported to work in [`Niri Window Manager`](https://github.com/YaLTeR/niri) instead of [`Hyprland`](https://hyprland.org). If you want installation instructions
> for the default caelestia dots, head to [the main repo](https://github.com/caelestia-dots/caelestia) instead.



<h1 align=center>niri-caelestia-shell</h1>


<div align=center>

![GitHub last commit](https://img.shields.io/github/last-commit/caelestia-dots/shell?style=for-the-badge&labelColor=101418&color=9ccbfb)
![GitHub Repo stars](https://img.shields.io/github/stars/caelestia-dots/shell?style=for-the-badge&labelColor=101418&color=b9c8da)
![GitHub repo size](https://img.shields.io/github/repo-size/caelestia-dots/shell?style=for-the-badge&labelColor=101418&color=d3bfe6)
[![Ko-Fi donate](https://img.shields.io/badge/donate-kofi?style=for-the-badge&logo=ko-fi&logoColor=ffffff&label=ko-fi&labelColor=101418&color=f16061&link=https%3A%2F%2Fko-fi.com%2Fsoramane)](https://ko-fi.com/soramane)

https://github.com/user-attachments/assets/0840f496-575c-4ca6-83a8-87bb01a85c5f

</div>

<div align=right>

***Components:***
[`Quickshell`](https://quickshell.outfoxxed.me)
[`Niri`](https://github.com/YaLTeR/niri)
~~[`caelestia-dots`](https://github.com/caelestia-dots)~~

</div>

---

- [🔽 Installation 🔽](#-installation-)
    - [👣 Installation Steps](#-installation-steps)
    - [📦 Dependencies](#-dependencies)
- [🔶 Usage 🔶](#-usage-)
    - [⌨️ Custom Shortcuts/IPC](#️-custom-shortcutsipc)
    - [🎭 PFP/Wallpapers](#-pfpwallpapers)
    - [🔃 Updating](#-updating)
    - [⚙️ Configuring](#️-configuring)
- [➕ My Additions ➕](#-my-additions-)
- [⛔ Known Issues ⛔](#-known-issues-)
- [❔ FAQ ❔](#-faq-)
    - [My screen is flickering, help pls!](#my-screen-is-flickering-help-pls)
    - [I want to make my own changes to the hyprland config!](#i-want-to-make-my-own-changes-to-the-hyprland-config)
    - [I want to make my own changes to other stuff!](#i-want-to-make-my-own-changes-to-other-stuff)
    - [I want to disable XXX feature!](#i-want-to-disable-xxx-feature)
    - [How do I make my colour scheme change with my wallpaper?](#how-do-i-make-my-colour-scheme-change-with-my-wallpaper)
    - [My wallpapers aren't showing up in the launcher!](#my-wallpapers-arent-showing-up-in-the-launcher)
- [🌟 Credits 🌟](#-credits-)
    - [Stonks 📈](#stonks-)

---


<!-- <div align=center> -->

<!-- [<kbd> <br>    🔽 Installation    <br> </kbd>](#🔽-installation-🔽)
[<kbd> <br>    📦 Dependencies    <br> </kbd>](#📦-dependencies)
[<kbd> <br> 🔶 Usage <br> </kbd>](#🔶-usage-🔶)

[<kbd> <br> 🔃 Updating <br> </kbd>](#🔃-updating)
[<kbd> <br> ⚙️ Configuring <br> </kbd>](#⚙️-configuring)
[<kbd> <br> ➕ My Additions <br> </kbd>](#➕-my-additions-➕)

[<kbd> <br> ⛔ Known Issues <br> </kbd>](#⛔-known-issues-⛔)
[<kbd> <br> 🌟 Credits <br> </kbd>](#🌟-credits-🌟) -->

<!-- </div> -->

<br>
<br>

# 🔽 Installation 🔽

> [!NOTE]
> There is **NO** package manager installation support yet because... 🤔

<br>

### 👣 Installation Steps

**1.** Install the dependencies listed below.
* Exapmle of what to do for CachyOS / Arch:
  1. `sudo pacman -S ddcutil brightnessctl cava networkmanager i2c-tools fish aubio libpipewire glibc qt6-declarative gcc-libs ttf-cascadia-code-nerd grim swappy libqalculate --needed`
  2. `paru ttf-material-symbols-variable-git app2unit-git --needed`

**2.** Either download the code, or clone this repo to your Quickshell config folder.
* **The folder is usually here:**
  - `~/.config/quickshell/niri-caelestia-shell`

**3.** Please read the first 2 lines of [Known Issues](#known-issues).

**4.** ***(Optional)*** Build the beat detector.
>
>If you want the Bongo Cat to clap along to your song, you need to compile the beat detector and install it to `/usr/lib/caelestia/beat_detector`.
>
>```sh
>cd $XDG_CONFIG_HOME/quickshell
>git clone https://github.com/caelestia-dots/shell.git caelestia
>g++ -std=c++17 -Wall -Wextra -I/usr/include/pipewire-0.3 -I/usr/include/spa-0.2 -I/usr/include/aubio -o beat_detector caelestia/assets/beat_detector.cpp -lpipewire-0.3 -laubio
>sudo mv beat_detector /usr/lib/caelestia/beat_detector
>```
>
> <sup> **The beat detector can actually be installed anywhere.** However, if it is not installed to the default location of `/usr/lib/caelestia/beat_detector`, you must set the environment variable `CAELESTIA_BD_PATH` to wherever you have installed the beat detector. </sup>
>
**6.** ***(Optional)*** This shell has a decent notification manager and an app launcher. If you wish, you can uninstall/disable `mako` and `fuzzel`. For app launcher, see [Custom Shortcuts/IPC](#custom-shortcutsipc).


<br>

### 📦 Dependencies

* All dependencies in plain text:
   * `quickshell-git networkmanager fish glibc qt6-declarative gcc-libs cava aubio libpipewire lm-sensors ddcutil brightnessctl material-symbols caskaydia-cove-nerd grim swappy app2unit libqalculate`

> [!NOTE]
>
> Unlike the default shell,
> [`caelestia-cli`](https://github.com/caelestia-dots/cli) is **not required for Niri**.

<br>

<details><summary> <b> Detailed info about all dependencies </b></summary>

<div align=left>

> <br>
>
>#### Core Dependencies 🖥️
>
>| Package | Usage |
>|---|---|
>| [`quickshell-git`](https://quickshell.outfoxxed.me) | Must be the git version |
>| [`networkmanager`](https://networkmanager.dev) | Network management |
>| [`fish`](https://github.com/fish-shell/fish-shell) | Terminal |
>| `glibc` | C library (runtime dependency) |
>| `qt6-declarative` | Qt components |
>| `gcc-libs` | GCC runtime |
>
>#### Audio & Visual 🎵
>
>| Package | Usage |
>|---|---|
>| [`cava`](https://github.com/karlstav/cava) | Audio visualizer |
>| [`aubio`](https://github.com/aubio/aubio) | Beat detector |
>| [`libpipewire`](https://pipewire.org) | Media backend |
>| [`lm-sensors`](https://github.com/lm-sensors/lm-sensors) | System usage monitoring |
>| [`ddcutil`](https://github.com/rockowitz/ddcutil) | Monitor brightness control |
>| [`brightnessctl`](https://github.com/Hummer12007/brightnessctl) | Brightness control |
>
>#### Fonts 🔣
>
>| Package | Usage |
>|---|---|
>| [`material-symbols`](https://fonts.google.com/icons) | Icon font |
>| [`jetbrains-mono-nerd`](https://www.nerdfonts.com/font-downloads) | Monospace font (Deprecated) |
>| [`caskaydia-cove-nerd`](https://www.nerdfonts.com/font-downloads) | Font |
>#### Screenshot & Utilities 🧰
>
>| Package | Usage |
>|---|---|
>| [`grim`](https://gitlab.freedesktop.org/emersion/grim) | Screenshot tool |
>| [`swappy`](https://github.com/jtheoof/swappy) | Screenshot annotation |
>| [`app2unit`](https://github.com/Vladimir-csp/app2unit) | Launch apps |
>| [`libqalculate`](https://github.com/Qalculate/libqalculate) | Calculator |

</div>

</details>

<br>
<br>

# 🔶 Usage 🔶

The shell can be started via the `quickshell -c niri-caelestia-shell -n` command or `qs -c niri-caelestia-shell -n` on your preferred terminal.
><sub> (`qs` and `quickshell` are interchangable.) </sub>


* Example line for niri `config.kdl` to launch the shell at startup:

   ```
   spawn-at-startup "quickshell" "-c" "niri-caelestia-shell" "-n"
   ```

<br>


### ⌨️ Custom Shortcuts/IPC

All keybinds are accessible via [Quickshell IPC msg](https://quickshell.org/docs/v0.1.0/types/Quickshell.Io/IpcHandler/).

All IPC commands can be called via `quickshell -c niri-caelestia-shell ipc call ...`

* For example:

   ```sh
   qs -c niri-caelestia-shell ipc call mpris getActive <trackTitle>
   ```

* Example shortcut in `config.kdl` to toggle the launcher drawer:
    ```sh
    Mod+Space { spawn  "qs" "-c" "shell" "ipc" "call" "drawers" "toggle" "launcher"; }
    ```

<br>


 The list of IPC commands can be shown via `qs -c shell ipc show`.

<br>

<details><summary> <b> Ipc Commands </b></summary>

  ```sh
  ❯ qs -c shell ipc show
  target picker
    function openFreeze(): void
    function open(): void
  target drawers
    function list(): string
    function toggle(drawer: string): void
  target lock
    function unlock(): void
    function isLocked(): bool
    function lock(): void
  target wallpaper
    function get(): string
    function set(path: string): void
    function list(): string
  target notifs
    function clear(): void
  target mpris
    function next(): void
    function previous(): void
    function getActive(prop: string): string
    function playPause(): void
    function pause(): void
    function stop(): void
    function list(): string
    function play(): void
  ```

</details>

<br>


### 🎭 PFP/Wallpapers

> [!WARNING]
> Not implemented yet!

The profile picture for the dashboard is read from the file `~/.face`, so to set
it you can copy your image to there or set it via the dashboard.

The wallpapers for the wallpaper switcher are read from `~/Pictures/Wallpapers`
by default. To change it, change the wallpapers path in `~/.config/caelestia/shell.json`.

To set the wallpaper, you can use the app launcher command `> wallpaper`.

<br>


### 🔃 Updating
You can update by running `git pull` in `$XDG_CONFIG_HOME/quickshell/niri-caelestia-shell`.

```sh
cd $XDG_CONFIG_HOME/quickshell/niri-caelestia-shell
git pull
```

<br>

### ⚙️ Configuring

All configuration options are in `~/.config/caelestia/shell.json`.

You might want to change your default apps.

<br>

> [!NOTE]
> The example configuration only includes recommended configuration options. For more advanced customisation
> such as modifying the size of individual items or changing constants in the code, there are some other
> options which can be found in the source files in the `config` directory.

<details><summary> <b> Example configuration </b></summary>

```json
{
    "appearance": {
        "anim": {
            "durations": {
                "scale": 1
            }
        },
        "font": {
            "family": {
                "material": "Material Symbols Rounded",
                "mono": "CaskaydiaCove NF",
                "sans": "Rubik"
            },
            "size": {
                "scale": 1
            }
        },
        "padding": {
            "scale": 1
        },
        "rounding": {
        	"scale": 1
        },
        "spacing": {
            "scale": 1
        },
        "transparency": {
            "enabled": false,
            "base": 0.85,
            "layers": 0.4
        }
    },
    "general": {
        "apps": {
            "terminal": ["foot"],
            "audio": ["pavucontrol"]
        }
    },
    "background": {
        "enabled": true
    },
    "bar": {
        "dragThreshold": 20,
        "persistent": true,
        "showOnHover": true,
        "status": {
            "showAudio": false,
            "showBattery": true,
            "showBluetooth": true,
            "showKbLayout": false,
            "showNetwork": true
        },
        "workspaces": {
            "activeIndicator": true,
            "activeLabel": "󰮯 ",
            "activeTrail": false,
            "label": "  ",
            "occupiedBg": false,
            "occupiedLabel": "󰮯 ",
            "rounded": true,
            "showWindows": true,
            "shown": 5
        }
    },
    "border": {
        "rounding": 25,
        "thickness": 10
    },
    "dashboard": {
        "mediaUpdateInterval": 500,
        "visualiserBars": 45
    },
    "launcher": {
        "actionPrefix": ">",
        "dragThreshold": 50,
        "vimKeybinds": false,
        "enableDangerousActions": false,
        "maxShown": 8,
        "maxWallpapers": 9,
        "useFuzzy": {
            "apps": false,
            "actions": false,
            "schemes": false,
            "variants": false,
            "wallpapers": false
        }
    },
    "lock": {
        "maxNotifs": 5
    },
    "notifs": {
        "actionOnClick": false,
        "clearThreshold": 0.3,
        "defaultExpireTimeout": 5000,
        "expandThreshold": 20,
        "expire": false
    },
    "osd": {
        "hideDelay": 2000
    },
    "paths": {
        "mediaGif": "root:/assets/bongocat.gif",
        "sessionGif": "root:/assets/kurukuru.gif",
        "wallpaperDir": "~/Pictures/Wallpapers"
    },
    "services": {
        "audioIncrement": 0.1,
        "weatherLocation": "10,10",
        "useFahrenheit": false,
        "useTwelveHourClock": false
    },
    "session": {
        "dragThreshold": 30,
        "vimKeybinds": false,
        "commands": {
            "logout": ["loginctl", "terminate-user", ""],
            "shutdown": ["systemctl", "poweroff"],
            "hibernate": ["systemctl", "hibernate"],
            "reboot": ["systemctl", "reboot"]
        }
    }
}
```

</details>

<br>
<br>

# ➕ My Additions ➕

- Clicking on Window Icon on workspace list focuses clicked window.
- Very WIP Niri management tab in dashboard.
- Task manager (Got from DankMaterialShell)
- Window switch popup
- Window decorations for pinning, hovering window, toggling fullscreen, and closing the window.
- Dashboard is now opened after clicking on the popup instead of completely popping up and taking up half the screen.
- More but I forgot...

<br>
<br>

# ⛔ Known Issues ⛔

- Since I don't have multiple monitors I just hard coded my monitor name in services/Visibilities.qml ❗
- My additions aren't toggleable yet ❗
- Focused window effects stay if you switch to a workspace with no windows.
- No Intel GPU monitoring in task manager 😿
- Currently, **Niri** doesn't have a way to check window sizes and location so the screenshot tool (picker) only functions as a standard screenshot tool.
- I will surely remember other issues...


<br>
<br>

<div align=center>
<b>(FAQ and Credits are unchanged, please don't forget to star the original config!!!)</b>
</div>
<br>


# ❔ FAQ ❔

### My screen is flickering, help pls!

Try disabling VRR in the hyprland config. You can do this by adding the following to `~/.config/caelestia/hypr-user.conf`:

```conf
misc {
    vrr = 0
}
```

### I want to make my own changes to the hyprland config!

You can add your custom hyprland configs to `~/.config/caelestia/hypr-user.conf`.

### I want to make my own changes to other stuff!

See the [manual installation](https://github.com/caelestia-dots/shell?tab=readme-ov-file#manual-installation) section
for the corresponding repo.

### I want to disable XXX feature!

Please read the [configuring](https://github.com/caelestia-dots/shell?tab=readme-ov-file#configuring) section in the readme.
If there is no corresponding option, make feature request.

### How do I make my colour scheme change with my wallpaper?

Set a wallpaper via the launcher or `caelestia wallpaper` and set the scheme to the dynamic scheme via the launcher
or `caelestia scheme set`. e.g.

```sh
caelestia wallpaper -f <path/to/file>
caelestia scheme set -n dynamic
```

### My wallpapers aren't showing up in the launcher!

The launcher pulls wallpapers from `~/Pictures/Wallpapers` by default. You can change this in the config. Additionally,
the launcher only shows an odd number of wallpapers at one time. If you only have 2 wallpapers, consider getting more
(or just putting one).

<br>
<br>

# 🌟 Credits 🌟

Thanks to the Hyprland discord community (especially the homies in #rice-discussion) for all the help and suggestions
for improving these dots!

A special thanks to [@outfoxxed](https://github.com/outfoxxed) for making Quickshell and the effort put into fixing issues
and implementing various feature requests.

Another special thanks to [@end_4](https://github.com/end-4) for his [config](https://github.com/end-4/dots-hyprland)
which helped me a lot with learning how to use Quickshell.

Finally another thank you to all the configs I took inspiration from (only one for now):

-   [Axenide/Ax-Shell](https://github.com/Axenide/Ax-Shell)

<br>
<br>
<br>


### Stonks 📈

<a href="https://www.star-history.com/#caelestia-dots/shell&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=caelestia-dots/shell&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=caelestia-dots/shell&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=caelestia-dots/shell&type=Date" />
 </picture>
</a>

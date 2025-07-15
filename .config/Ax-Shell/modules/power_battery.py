import logging
import subprocess

from fabric.widgets.box import Box
from fabric.widgets.button import Button


logger = logging.getLogger(__name__)

class PowerBattery(Box):
    def __init__(self) -> None:
        super().__init__(
            name="power-battery",
            orientation="v",
            h_expand=True,
            h_fill=True,
            v_expand=False,
            v_fill=False,
            spacing=10,
            padding=10,
            size=10,
        )
        self.performance_button = Button(
            label="󰓅",
            name="performance-button",
            markup="Performance",
            h_expand=False,
            v_expand=False,
            on_clicked=self.set_performance,
        )
        self.balanced_button = Button(
            label="",
            name="balanced-button",
            markup="Balanced",
            h_expand=False,
            v_expand=False,
            on_clicked=self.set_balanced,
        )
        self.power_save_button = Button(
            label="󱐌",
            name="power-save-button",
            markup="Power Save",
            h_expand=False,
            v_expand=False,
            on_clicked=self.set_power_save,
        )

        self.children_1 = [
            self.performance_button,
            self.balanced_button,
            self.power_save_button,
        ]
        self.container_1 = Box(
            name="power-battery-container",
            orientation="horizontal",
            h_expand=True,
            h_fill=True,
            v_expand=False,
            v_fill=False,
            spacing=10,
            padding=10,
            children=self.children_1,
        )
        self.add(self.container_1)
        self.highlight_active_profile()

    def set_performance(self, *_):
        logger.info("Setting performance profile")
        subprocess.run(["powerprofilesctl", "set", "performance"])
        self.highlight_active_profile()

    def set_balanced(self, *_):
        logger.info("Setting balanced profile")
        subprocess.run(["powerprofilesctl", "set", "balanced"])
        self.highlight_active_profile()

    def set_power_save(self, *_):
        logger.info("Setting power save profile")
        subprocess.run(["powerprofilesctl", "set", "power-saver"])
        self.highlight_active_profile()

    def highlight_active_profile(self):
        for button in [self.performance_button, self.balanced_button, self.power_save_button]:
            button.remove_style_class("active")

        result = subprocess.run(["powerprofilesctl", "get"], capture_output=True, text=True)
        current = result.stdout.strip()

        for button in self.children:
            button.remove_style_class("active")

        if current == "performance":
            self.performance_button.add_style_class("active")
        elif current == "balanced":
            self.balanced_button.add_style_class("active")
        elif current == "power-saver":
            self.power_save_button.add_style_class("active")

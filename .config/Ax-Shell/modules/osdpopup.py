from widgets.wayland import WaylandWindow as Window
from fabric.widgets.label import Label


class OSDWidget(Window):
    def __init__(self):
        super().__init__(
            name="osd-widget",
            layer="overlay",
            anchor="bottom center",
            margin="0px 0px 100px 0px",
            pass_through=True,
            visible=True,
        )

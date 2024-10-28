import brightness from "./brightness.js";
import GLib from "gi://GLib";
import Gio from "gi://Gio";

const hyprland = await Service.import("hyprland");
const audio = await Service.import("audio");
const battery = await Service.import("battery");
const applications = await Service.import("applications");

// Thanks stack overflow :)
function toTitleCase(str) {
  return str.replace(
    /\w\S*/g,
    (text) => text.charAt(0).toUpperCase() + text.substring(1).toLowerCase(),
  );
}

function Bar(name, monitor) {
  const workspaces = Widget.Box({
    vertical: true,
    className: "workspaces",
    children: Array(5)
      .fill(0)
      .map((_, i) =>
        Widget.Button({
          label: (i + 1).toString(),
          onClicked: () =>
            hyprland.messageAsync(
              `dispatch focusworkspaceoncurrentmonitor ${i + 1}`,
            ),
          setup: (self) =>
            self.hook(
              hyprland,
              (self) =>
                (self.class_name = `${
                  hyprland.active.workspace.id === i + 1
                    ? "active"
                    : hyprland.workspaces[i]?.windows > 0
                      ? "full"
                      : "empty"
                } workspace`),
            ),
        }),
      ),
  });

  const windows = Widget.Box({
    vertical: true,
    className: "windows",
    setup: (self) =>
      self.hook(hyprland, (self) => {
        self.children = hyprland.clients
          .filter(
            (client) => client.workspace.id === hyprland.active.workspace.id,
          )
          .map((client) =>
            Widget.Button({
              label: toTitleCase(
                (
                  applications.query(client.initialClass)[0] ??
                  client.initialClass
                ).name.substring(0, 2),
              ),
              className: `${
                hyprland.active.client.address === client.address
                  ? "active"
                  : "inactive"
              } window`,
              onPrimaryClick: () => {
                hyprland.messageAsync(
                  `dispatch alterzorder top,address:${client.address}`,
                );
                hyprland.messageAsync(
                  `dispatch focuswindow address:${client.address}`,
                );
              },
              onMiddleClick: () =>
                hyprland.messageAsync(
                  `dispatch closewindow address:${client.address}`,
                ),
            }),
          );
      }),
  });

  const batteryWidget = Widget.Label({
    label: battery.bind("percent").as((percent) => `${percent}%`),
    className: Utils.merge(
      [
        battery.bind("percent"),
        battery.bind("charging"),
        battery.bind("charged"),
      ],
      (percent, charging, charged) =>
        `${
          charging || charged
            ? "good"
            : percent <= 15
              ? "critical"
              : percent <= 25
                ? "low"
                : ""
        } battery`,
    ),
  });

  const date = Widget.Box({
    vertical: true,
    className: "date",
    children: [
      Widget.Label({
        setup: (self) =>
          self.poll(1000, (self) => (self.label = Utils.exec("date +%d"))),
      }),
      Widget.Label({
        setup: (self) =>
          self.poll(1000, (self) => (self.label = Utils.exec("date +%m"))),
      }),
    ],
  });

  const time = Widget.Box({
    vertical: true,
    className: "time",
    children: [
      Widget.Label({
        setup: (self) =>
          self.poll(1000, (self) => (self.label = Utils.exec("date +%I"))),
      }),
      Widget.Label({
        setup: (self) =>
          self.poll(1000, (self) => (self.label = Utils.exec("date +%M"))),
      }),
    ],
  });

  const dateTime = Widget.Box({
    vertical: true,
    spacing: 10,
    className: "date-time",
    children: [date, time],
  });

  const info = Widget.Box({
    vertical: true,
    vpack: "end",
    className: "info",
    spacing: 32,
    children: [batteryWidget, dateTime],
  });

  const centerBox = Widget.CenterBox({
    vertical: true,
    className: "center-box",
    startWidget: workspaces,
    centerWidget: windows,
    endWidget: info,
  });

  return Widget.Window({
    className: "bar",
    name: `bar${name}`,
    anchor: ["top", "left", "bottom"],
    child: centerBox,
    monitor,
    exclusivity: "exclusive",
    margins: [200, 0, 200, 10],
  });
}

function Percent(percent, icon) {
  const progressBar = Widget.LevelBar({
    className: "percent-bar",
    value: percent,
    heightRequest: 300,
    widthRequest: 40,
    vertical: true,
  });

  const percentLabel = Widget.Label({
    className: `percent-label ${Math.round(percent * 100) > 49 ? "dark" : ""}`,
    label: (percent * 100).toFixed(0),
  });

  const iconLabel = Widget.Label({
    className: `percent-label ${Math.round(percent * 100) > 59 ? "dark" : ""}`,
    label: icon,
  });

  const labels = Widget.Box({
    className: "percent-labels",
    children: [percentLabel, iconLabel],
    vertical: true,
    spacing: 12,
    vpack: "center",
  });

  const overlay = Widget.Overlay({
    className: "percent-overlay",
    child: progressBar,
    overlays: [labels],
  });

  return Widget.Window({
    className: "percent",
    name: `percent`,
    anchor: ["right"],
    child: overlay,
    margins: [0, 20, 0, 0],
  });
}

let previousTimeout = 0;
let previousVolume;
let previousMute;
let previousVolumeMic;
let previousMuteMic;

audio.connect("speaker-changed", (audio) => {
  if (
    audio.speaker.volume === previousVolume &&
    audio.speaker.is_muted === previousMute
  )
    return;
  previousVolume = audio.speaker.volume;
  previousMute = audio.speaker.is_muted;
  if (App.getWindow("percent") != null) {
    App.removeWindow("percent");
    GLib.source_remove(previousTimeout);
  }
  App.addWindow(
    Percent(audio.speaker.is_muted ? 0 : audio.speaker.volume, "󰖀"),
  );
  previousTimeout = Utils.timeout(1000, () => App.removeWindow("percent"));
});

audio.connect("microphone-changed", (audio) => {
  if (
    audio.microphone.volume === previousVolumeMic &&
    audio.microphone.is_muted === previousMuteMic
  )
    return;
  previousVolumeMic = audio.microphone.volume;
  previousMuteMic = audio.microphone.is_muted;
  if (App.getWindow("percent") != null) {
    App.removeWindow("percent");
    GLib.source_remove(previousTimeout);
  }
  App.addWindow(
    Percent(audio.microphone.is_muted ? 0 : audio.microphone.volume, "󰍬"),
  );
  previousTimeout = Utils.timeout(1000, () => App.removeWindow("percent"));
});

brightness.connect("screen-changed", (brightness) => {
  if (App.getWindow("percent") != null) {
    App.removeWindow("percent");
    GLib.source_remove(previousTimeout);
  }
  App.addWindow(Percent(brightness.screenValue, "󰖙"));
  previousTimeout = Utils.timeout(1000, () => App.removeWindow("percent"));
});

hyprland.connect("monitor-added", (_, name) => {
  App.addWindow(
    Bar(name, hyprland.monitors.find((monitor) => monitor.name === name)?.id),
  );
});

hyprland.connect("monitor-removed", (_, name) => {
  App.removeWindow(`bar${name}`);
});

const filepath = GLib.build_filenamev([GLib.get_home_dir(), "colors.json"]);

const file = Gio.File.new_for_path(filepath);

App.applyCss(
  `${Object.entries(JSON.parse(Utils.readFile(file)))
    .map(([base, color]) => `@define-color ${base} #${color};`)
    .join("")}${Utils.readFile(`${App.configDir}/styles.css`)}`,
);

App.config({
  windows: hyprland.monitors.map((monitor) => Bar(monitor.name, monitor.id)),
});

# monkeytype: https://monkeytype.com?customTheme=eyJjIjpbIiMxNjE2MTYiLCIjYzBhNDc5IiwiI2MwYTQ3OSIsIiM2MjYyNjIiLCIjMWUxZTFlIiwiI2E4YThhOCIsIiNiNzgzNjUiLCIjYWM2ZjZiIiwiI2I3ODM2NSIsIiNhYzZmNmIiXX0=

{ config, ... }:
{
  programs.firefox = {
		enable = true;
		profiles.remy = {
			settings = {
				"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
				"browser.uiCustomization.state" = ''browser.uiCustomization.state	{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["back-button","forward-button","stop-reload-button","customizableui-special-spring1","urlbar-container","customizableui-special-spring2","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar"],"currentVersion":20,"newElementCount":3}'';
			};

			userChrome = /* css */ ''
.titlebar-buttonbox-container, #alltabs-button, #tabbrowser-arrowscrollbox-periphery, .tab-close-button, .tab-background, .titlebar-spacer, .tabbrowser-tab:not([fadein]), .tab-icon-stack {
  display: none;
}

#navigator-toolbox {
  border-bottom: none !important;
}

#titlebar {
  height: 40px;
  z-index: 2;
  background-color: #${config.lib.stylix.colors.base01} !important;
  
  &:-moz-window-inactive {
    background-color: #${config.lib.stylix.colors.base00} !important;
    opacity: 1 !important;
  }
}

#nav-bar {
  position: fixed !important;
  opacity: 0;
  transition: opacity 0.5s ease, top 0.5s ease;
  top: 0;
  right: 0;
  left: 0;
  z-index: 1;
}

#navigator-toolbox:is(:hover, :focus-within) > #nav-bar {
  top: 40px;
  opacity: 1;
}

.tabbrowser-tab {
  font-family: JetBrainsMono Nerd Font;
  padding: 0 !important;
  margin: 0 !important;
  flex: 1 !important;
  max-width: none !important;
	opacity: 1;
	transition: opacity 0.5s ease;

	&:hover {
		opacity: 0.5;
	}
}

.tab-content {
  margin-inline: auto;
	max-width: 100%;
}

.tab-text {
  margin-bottom: 2px !important;
  margin-left: 4px !important;
	text-overflow: ellipsis;
	overflow: hidden;
  
  &:not([selected]) {
    color: #${config.lib.stylix.colors.base03};
		&:-moz-window-inactive {
    	color: #${config.lib.stylix.colors.base02};
		}
  }

	&:-moz-window-inactive {
		color: #${config.lib.stylix.colors.base03}
	}
}
			'';
		};
	};
}

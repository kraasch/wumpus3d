dummy:
	@echo 'Please specify the exact rule to run ;)'

web_all:
	make web_export
	make web_push
	make web_show

web_export:
	cd ..; godot4 --headless --path . --export-release Web ./export/channels/web/index.html

web_push:
	butler push ./channels/web/ kraasch/wumpus:html

web_show:
	xdg-open 'https://kraasch.itch.io/wumpus'

package menus;

import menus.components.MainMenuItem;

class MainMenuState extends FlxState
{
	public var MENU_ITEMS:Array<MainMenuItem> = [
		{
			name: 'character file converter',
			item_function: () -> FlxG.switchState(new MainMenuState()),
			disabled: false
		},
		{
			name: 'song file converter',
			disabled: true
		}
	];

	public var TEXT_DISTANCE:Float = 16;

	public var CURRENT_SELECTION:Int = 0;

	public var MENU_ITEM_TEXT_GROUP:FlxTypedGroup<FlxText>;

	override public function create()
	{
		MENU_ITEM_TEXT_GROUP = new FlxTypedGroup<FlxText>();
		add(MENU_ITEM_TEXT_GROUP);

		var text_padding:Float = 10;
		var index:Int = 0;

		for (item in MENU_ITEMS)
		{
			var text:FlxText = new FlxText(text_padding, text_padding + (index * TEXT_DISTANCE), 0, MENU_ITEMS[index].name, 16);
			text.color = 0xFFFFFF;
			text.ID = index;
			MENU_ITEM_TEXT_GROUP.add(text);

			index++;
		}

		updateMenuText();

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justReleased.UP) {CURRENT_SELECTION = (CURRENT_SELECTION - 1 <=  0 ) ? 0 : CURRENT_SELECTION - 1; updateMenuText();}
		if (FlxG.keys.justReleased.DOWN) {CURRENT_SELECTION = (CURRENT_SELECTION + 1 >=  MENU_ITEMS.length ) ? MENU_ITEMS.length - 1 : CURRENT_SELECTION + 1; updateMenuText();}

		super.update(elapsed);
	}
	
	public function updateMenuText()
	{
		var index:Int = 0;

		for (item in MENU_ITEMS)
		{
			var text:FlxText = MENU_ITEM_TEXT_GROUP.members[index];

			text.color = ((CURRENT_SELECTION != text.ID ) ? ( (item.disabled) ? 0x2D2D2D : 0xFFFFFF) : ( (item.disabled) ? 0x2D2D00 : 0xFFFF00));
		}
	}
}

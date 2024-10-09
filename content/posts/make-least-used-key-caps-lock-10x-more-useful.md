+++
title = 'Make Your Least Used Key (Caps Lock) 10x More Useful'
date = 2024-10-08T08:32:16-04:00
+++

You can make you <kbd>caps lock</kbd> more useful by remapping it to the <kbd>esc</kbd> or the **hyper** key,
a combination of <kbd>alt</kbd><kbd>shift</kbd><kbd>ctrl</kbd><kbd>cmd</kbd>, that can be used for global shortcuts
because no other application is likely to shortcuts that use *all* the modifier keys.

## Why

You probably use Shift for capitalization, while caps-lock just sits there taking up valuable real estate on your computer.

### Hyper

For instance I have the following shortcuts setup:
1. No more constant Cmd+tabbing. Instead for switching between constantly used apps I have:
    1. <kbd>caps lock</kbd><kbd>i</kbd> -> launch/switch to IntelliJ IDEA
    2. <kbd>caps lock</kbd><kbd>t</kbd> -> launch/switch to iTerm
    3. <kbd>caps lock</kbd><kbd>b</kbd> -> launch/switch to browser (currently Firefox or Vivaldi)
    4. <kbd>caps lock</kbd><kbd>g</kbd> -> launch/switch to Spotify (g is closer to the hyper key on my external keyboard)
    5. <kbd>caps lock</kbd><kbd>s</kbd> -> switch to Slack
    6. <kbd>caps lock</kbd><kbd>0</kbd> -> switch to Obsidian
2. Automating tasks:
    1. <kbd>caps lock</kbd><kbd>1</kbd> ... <kbd>4</kbd> -> update Slack status
    2. <kbd>caps lock</kbd><kbd>5</kbd> -> put computer to sleep

### Esc

<kbd>caps lock</kbd> is easier to reach then <kbd>esc</kbd> on the Macbook Pro keyboard!

## How

### Remapping
A common way to accomplish this is via Karabiner-Elements, but I have found that to be buggy [^1], or it might not be on your organization's allowed list of apps. Additionally, I would prefer to not have another app using my compute resources for such a minor utility.

Instead, a better and easier method is to use [hidutil](https://developer.apple.com/library/archive/technotes/tn2450/_index.html) -- a key remapping tool built into MacOS. 
I created a short script to generate the configuration file (or adding the appropriate mapping if file already exists). 
You can run it by executing the following command (you will need [NodeJS](https://nodejs.org/) installed).

```shell  
curl -fSSL https://github.com/bcosynot/hyperutil/raw/refs/heads/main/capsLockOnHyperdrive.js | node  
```

After running this, restart your computer.

For more information about this script, take a look at the [hyperutil repo on GitHub](https://github.com/bcosynot/hyperutil).

### Configuring shortcuts with Hammerspoon

#### Install Hammerspoon

First, install Hammerspoon if you don't already have it. You can follow the "Setup" instructions outlined in their [Getting Started](https://www.hammerspoon.org/go/) guide.

#### Configure hyper mode

Once installed, open the configuration file in your favorite text editor and add the following code

```lua
-- A global variable for the Hyper Mode
hyper = hs.hotkey.modal.new({}, nil)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
function enterHyperMode()
  hyper.triggered = false
  hyper:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- send ESCAPE if no other keys are pressed.
function exitHyperMode()
  hyper:exit()
  if not hyper.triggered then
    -- BONUS! caps-lock acts as esc with a short tap
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', enterHyperMode, exitHyperMode)
```

This gets you setup to enter hyper mode while caps-lock is pressed and exit it when it is released.

#### Shortcuts

Next, lets setup some shortcuts to switch between regularly used apps. As an example, let's start with IntelliJ

```lua
hyper:bind({}, 'i', function()
  hs.eventtap.keyStroke({ "alt", "shift", "ctrl", "cmd" }, 'i')
  hyper.triggered = true
end)
hs.hotkey.bind({ "alt", "shift", "ctrl", "cmd" }, "i", function()
  hs.application.launchOrFocus("IntelliJ IDEA Ultimate")
end)
```

The first line in this code block defines what to do when `i` is pressed while `hyper` mode is active. Here we tell Hammerspoon to simulate tapping the hyper key [^2] along with `i`.

The next block of code tells Hammerspoon to launch or focus to IntelliJ when it detects the hyper key combo is pressed with `i`. I am not doing this in the previous block of code because I use another programmable keyboard with a standalone hyper key -- and I want this configuration to work with that keyboard.

You can replace this block with a simpler loop to setup these shortcuts for multiple apps like so

```lua
-- Shortcuts to launch or switch focus to specific apps
keyApps = {
	['i'] = 'Intellij IDEA Ultimate',
	['b'] = 'Firefox', -- replace with your favorite browser
	['t'] = 'iTerm',
	['m'] = 'Telegram',
	['s'] = 'Slack',
	['g'] = 'Spotify',
	['o'] = 'Obsidian'
}

for key, app in pairs(keyApps) do
	-- First, bind the `key` when pressed in `hyper` mode to simulate tapping the hyper key
	hyper:bind({}, key, function()
		hs.eventtap.keyStroke({ "alt", "shift", "ctrl", "cmd" }, key)
		hyper.triggered = true
	end)
	-- Then setup the app to launch or focus when configured key is pressed along with hyper key
	-- This is useful if your programmable keyboard has a standalone hyper key
	hs.hotkey.bind({ "alt", "shift", "ctrl", "cmd" }, key, function ()
		hs.application.launchOrFocus(app)
	end)
end
```

The `keyApps` table contains mappings for keys to their respective apps. We then loop over these mappings to setup appropriate bindings like before.

### Completing the configuration

At the end your Hammerspoon file should look like this
```lua
-- A global variable for the Hyper Mode
hyper = hs.hotkey.modal.new({}, nil)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
function enterHyperMode()
  hyper.triggered = false
  hyper:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- send ESCAPE if no other keys are pressed.
function exitHyperMode()
  hyper:exit()
  if not hyper.triggered then
	-- BONUS! caps-lock acts as esc with a short tap
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', enterHyperMode, exitHyperMode)


-- Shortcuts to launch or switch focus to specific apps
keyApps = {
	['i'] = 'Intellij IDEA Ultimate',
	['b'] = 'Firefox', -- replace with your favorite browser
	['t'] = 'iTerm',
	['m'] = 'Telegram',
	['s'] = 'Slack',
	['g'] = 'Spotify',
	['o'] = 'Obsidian'
}

for key, app in pairs(keyApps) do
	-- First, bind the `key` when pressed in `hyper` mode to simulate tapping the hyper key
	hyper:bind({}, key, function()
		hs.eventtap.keyStroke({ "alt", "shift", "ctrl", "cmd" }, key)
		hyper.triggered = true
	end)
	-- Then setup the app to launch or focus when configured key is pressed along with hyper key
	-- This is useful if your programmable keyboard has a standalone hyper key
	hs.hotkey.bind({ "alt", "shift", "ctrl", "cmd" }, key, function ()
		hs.application.launchOrFocus(app)
	end)
end
```

Save this file and then reload your configuration from Hammerspoon's menu bar icon. You should be able to launch or switch apps when you hit your configured keys with `caps-lock`

[^1]: After waking the computer from sleep, my keyboard is completely unresponsive until I restart Karabiner-Elements -- regardless of how I setup my computer.
[^2]: Mentioned earlier in the post the **hyper** key is a combination of "alt", "shift", "ctrl", "cmd". This can be used for global shortcuts because no other application is likely to shortcuts that use *all* the modifier keys.
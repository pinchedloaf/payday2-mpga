payday2-mpga
------------
Make Payday 2 Great Again.*

Required Versions
-----------------
SuperBLT 2.0+ (r6_r16) or later
- https://superblt.znix.xyz/

Payday 2
- Update 200.1 (2020-11-13)

Installation
------------
- Add `WSOCK32.dll` to `payday2` root directory.
- Copy MPGA to `mods` sub-directory.
- Launch. SuperBLT will automatically update if needed.

Notes
-----
- Fast Bile: Immediately spawn bile helicopter drops.
- Time for Callout: Time between Bain cooking callouts.
- Twitch Stay: Make Twitch stay.
- Incognito: Don't display mod to other players.
 
Developer Notes
---------------

tweakdata.lua
| var               | difficulty | HP* | Headshot* | Enemy AI  |
|-------------------|------------|-----|-----------|-----------|
| _set_easy         | normal     | 1   | 1         | normal    |
| _set_normal       | hard       | 1   | 1+falloff | normal    |
| _set_hard         | very hard  | 1   | 1         | normal    |
| _set_overkill     | overkill   | 2   | 2         | good      |
| _set_overkill_145 | mayhem     | 3   | 3         | expert    |
| _set_easy_wish    | deathwish  | 6   | 1.5       | expert    |
| _set_overkill_290 | one down   | 6   | 1.5       | deathwish |

* This is sarcasm. MAGA is stupid. Don't be snowflakes.

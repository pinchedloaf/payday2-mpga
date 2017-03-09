payday2-mpga
------------
Make Payday 2 Great Again.

Required Versions
-----------------
BLT 1.08+ (r15_r5) or later
- https://github.com/JamesWilko/Payday-2-BLT/releases/tag/1.08

Payday 2
- Update 133 (2017-03-02)

Installation
------------
- Copy to mods directory after setting up BLT.

Notes
-----
Resets the One Down multipliers to classic Deathwish.

Developer Notes
---------------

| var               | difficulty | HP* | Headshot* | Enemy AI  |
|-------------------|------------|-----|-----------|-----------|
| _set_easy         | normal     | 1   | 1         | normal    |
| _set_normal       | hard       | 1   | 1+falloff | normal    |
| _set_hard         | very hard  | 1   | 1         | normal    |
| _set_overkill     | overkill   | 2   | 2         | good      |
| _set_overkill_145 | mayhem     | 3   | 3         | expert    |
| _set_easy_wish    | deathwish  | 6   | 1.5       | expert    |
| _set_overkill_290 | one down   | 6   | 1.5       | deathwish |

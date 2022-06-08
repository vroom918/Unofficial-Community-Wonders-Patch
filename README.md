# Unofficial World Wonders Collection Bugs and Balance Patch

A Civ 6 mod which fixes some bugs with various other mods in the [World Wonders Collection](https://steamcommunity.com/workshop/filedetails/?id=1736440697) and makes some balance changes. I do not own those mods nor am I affiliated with them, but they're quality stuff and just missing a few things.

## Requirements

None! This mod should be compatible with any version of Civ 6, any DLC, and any mod list. Aside from creating localization entries, all of the changes are only applied if the thing they're trying to change already exists. So whether you have none of the wonder mods or all of them this mod should be safe to use.

## Install Instructions

Clone this repository, then copy the `WorldWonders-Patch` folder into your Civ 6 Mods folder (defaults to `C:\Users\<you>\Documents\my games\Sid Meier's Civilization VI\Mods` on a Windows Steam install).

## Changes

### Bug Fixes

- Various text updates to make wonder descriptions more similar to existing game effects

### Balance Changes

- Neuschwanstein Castle:
    - Changed placement requirements so that it must be built on a non-desert mountain (which also looks better to me)
        - Note that this means you can't active a Great Musician on the wonder, so you can't fill the great work slots directly and must move great works to the wonder
    - Changed the requirement for cities to receive the wonder's modifier to only check for medieval walls. This doesn't change anything in practice, but it does make the description a bit more concise
    - Added +1 amenity from entertainment to the wonder itself
    - Changed the wonder's gold yield and the yield bonus to cities with medieval walls to +3 (previously +2)
- Porcelain Tower:
    - Reduce amenities from porcelain to +4 (was +6)
    - Reduce porcelain quanity to 2 (was 3)
    - Grants a Great Scientist upon completion
- Itsukushima Shrine
    - Grants a free Shrine instead of a Monument (it's called Itsukushima *Shrine* after all!)
- Borobudur
    - Adds a Holy Site adjacency requirement

### Known Issues

- Neuschwanstein Castle:
    - I tried to update the German text but I don't speak the language so it may be nonsense
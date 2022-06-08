/*
	World Wonders Collection Balance Fixes
	Authors: vroom918
*/

-----------------------------------------------
-- Neuschwanstein Castle:
--   Must be built on a non-desert mountain
--	 Remove mountain adjacency requirement
--	 +1 amenity from entertainment
--	 Increase wonder gold yield to +3 (was +2)
--	 Increase gold for cities with medieval walls to +3 (was +2)
--	 Change requirement to look for medieval walls only (doesn't actually change anything, just makes me feel better)
-----------------------------------------------

DELETE FROM Building_ValidTerrains WHERE BuildingType = 'BUILDING_NEUSCHWANSTEIN';

INSERT INTO Building_ValidTerrains 	
SELECT 'BUILDING_NEUSCHWANSTEIN', 'TERRAIN_GRASS_MOUNTAIN'
WHERE EXISTS (SELECT * FROM Types WHERE Type = 'BUILDING_NEUSCHWANSTEIN');

INSERT INTO Building_ValidTerrains 	
SELECT 'BUILDING_NEUSCHWANSTEIN', 'TERRAIN_PLAINS_MOUNTAIN'
WHERE EXISTS (SELECT * FROM Types WHERE Type = 'BUILDING_NEUSCHWANSTEIN');

INSERT INTO Building_ValidTerrains 	
SELECT 'BUILDING_NEUSCHWANSTEIN', 'TERRAIN_TUNDRA_MOUNTAIN'
WHERE EXISTS (SELECT * FROM Types WHERE Type = 'BUILDING_NEUSCHWANSTEIN');

INSERT INTO Building_ValidTerrains 	
SELECT 'BUILDING_NEUSCHWANSTEIN', 'TERRAIN_SNOW_MOUNTAIN'
WHERE EXISTS (SELECT * FROM Types WHERE Type = 'BUILDING_NEUSCHWANSTEIN');

UPDATE Buildings
SET AdjacentToMountain = 0, Entertainment = 1
WHERE BuildingType = 'BUILDING_NEUSCHWANSTEIN';

UPDATE Building_YieldChanges
SET YieldChange = 3
WHERE BuildingType = 'BUILDING_NEUSCHWANSTEIN' AND YieldType = 'YIELD_GOLD';

UPDATE ModifierArguments
SET Value = 3
WHERE ModifierId = 'NEUSCHWANSTEIN_WALLS_GOLD_MODIFIER' AND Name = 'Amount';

DELETE FROM RequirementSetRequirements
WHERE RequirementSetId = 'CITY_HAS_MED_OR_REN_WALLS_REQUIREMENTS' AND RequirementId = 'REQUIRES_CITY_HAS_RENAISSANCE_WALLS';

-----------------------------------------------
-- Porcelain Tower:
--   Reduce Porcelain amenities to +4 (was +6)
--	 Reduce Porcelain quantity to 2 (was 3)
--	 Grants a Great Scientist on completion
-----------------------------------------------

UPDATE Resources
SET Happiness = 4
WHERE ResourceType = 'RESOURCE_PORCELAIN';

UPDATE ModifierArguments
SET Value = 2
WHERE ModifierId = 'PORCELAIN_TOWER_CITY_FREE_PORCELAIN' AND Name = 'Amount';

INSERT INTO Requirements
		(RequirementId,								RequirementType)
SELECT	'REQUIRES_PLAYER_CAN_EVER_EARN_SCIENTIST',	'REQUIREMENT_PLAYER_CAN_EVER_EARN_GREAT_PERSON_CLASS'
WHERE EXISTS (SELECT * FROM Types WHERE Type = 'BUILDING_PORCELAIN_TOWER');

INSERT INTO RequirementSets
		(RequirementSetId,							RequirementSetType)
SELECT	'PORCELAIN_TOWER_SCIENTIST_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL'
WHERE EXISTS (SELECT * FROM Types WHERE Type = 'BUILDING_PORCELAIN_TOWER');

INSERT INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
SELECT	'PORCELAIN_TOWER_SCIENTIST_REQUIREMENTS',	'REQUIRES_PLAYER_CAN_EVER_EARN_SCIENTIST'
WHERE EXISTS (SELECT * FROM Types WHERE Type = 'BUILDING_PORCELAIN_TOWER');

INSERT INTO RequirementArguments
		(RequirementId,								Name,				Value)
SELECT	'REQUIRES_PLAYER_CAN_EVER_EARN_SCIENTIST',	'GreatPersonClass',	'GREAT_PERSON_CLASS_SCIENTIST'
WHERE EXISTS (SELECT * FROM Types WHERE Type = 'BUILDING_PORCELAIN_TOWER');

INSERT INTO Modifiers
		(ModifierId,						ModifierType,											RunOnce,	Permanent,	SubjectRequirementSetId)
SELECT	'PORCELAIN_TOWER_GRANT_SCIENTIST', 'MODIFIER_SINGLE_CITY_GRANT_GREAT_PERSON_CLASS_IN_CITY',	1,			1,			'PORCELAIN_TOWER_SCIENTIST_REQUIREMENTS'
WHERE EXISTS (SELECT * FROM Types WHERE Type = 'BUILDING_PORCELAIN_TOWER');

INSERT INTO ModifierArguments
		(ModifierId,						Name, 					Value)
SELECT	'PORCELAIN_TOWER_GRANT_SCIENTIST',	'GreatPersonClassType',	'GREAT_PERSON_CLASS_SCIENTIST'
WHERE EXISTS (SELECT * FROM Types WHERE Type = 'BUILDING_PORCELAIN_TOWER');

INSERT INTO ModifierArguments
		(ModifierId,						Name, 					Value)
SELECT	'PORCELAIN_TOWER_GRANT_SCIENTIST',	'Amount',				1
WHERE EXISTS (SELECT * FROM Types WHERE Type = 'BUILDING_PORCELAIN_TOWER');

INSERT INTO BuildingModifiers
		(BuildingType,				ModifierId)
SELECT	'BUILDING_PORCELAIN_TOWER',	'PORCELAIN_TOWER_GRANT_SCIENTIST'
WHERE EXISTS (SELECT * FROM Types WHERE Type = 'BUILDING_PORCELAIN_TOWER');

-----------------------------------------------
-- Itsukushima Shrine:
--   Grant a Shrine instead of a Monument
-----------------------------------------------

UPDATE ModifierArguments
SET Value = 'BUILDING_SHRINE'
WHERE ModifierId = 'ITSUKUSHIMA_GRANT_MONUMENT' AND Name = 'BuildingType';

-----------------------------------------------
-- Borobudur:
--   Must be adjacent to a holy site
-----------------------------------------------

UPDATE Buildings
SET AdjacentDistrict = 'DISTRICT_HOLY_SITE'
WHERE BuildingType = 'BUILDING_BOROBUDUR';
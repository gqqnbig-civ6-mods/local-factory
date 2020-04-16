-- LocalFactory_Technologies
-- Author: gqqnb
-- DateCreated: 4/15/2020 6:30:07 PM
--------------------------------------------------------------


INSERT into Requirements(RequirementId, RequirementType)
values	('REQUIRES_PLAYER_HAS_2_REGIONAL_POWER_PLANTS', 'REQUIREMENT_CITY_HAS_BUILDING'),
		('REQUIRES_PLAYER_HAS_2_LOCAL_POWER_PLANTS', 'REQUIREMENT_CITY_HAS_BUILDING')


insert into RequirementSets
values('REQUIRES_PLAYER_HAS_ANY_2_POWER_PLANTS','REQUIREMENTSET_TEST_ANY');

insert into RequirementSetRequirements
values	('REQUIRES_PLAYER_HAS_ANY_2_POWER_PLANTS', 'REQUIRES_PLAYER_HAS_2_REGIONAL_POWER_PLANTS' ),
		('REQUIRES_PLAYER_HAS_ANY_2_POWER_PLANTS', 'REQUIRES_PLAYER_HAS_2_LOCAL_POWER_PLANTS' );


update Boosts
set TriggerDescription='LOC_BOOST_TRIGGER_MUST_STEAL', 
	BoostClass='BOOST_TRIGGER_REQUIERMENTSET', -- 注意REQUIERMENTSET含有拼写错误，是原版自带的
	RequirementSetId='REQUIRES_PLAYER_HAS_ANY_2_POWER_PLANTS',
	BuildingType=null,
	NumItems=0
where TechnologyType='TECH_ADVANCED_BALLISTICS' and BuildingType="BUILDING_POWER_PLANT" and NumItems="2";


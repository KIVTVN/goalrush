CREATE TABLE teams (
  id varchar(36) PRIMARY KEY NOT NULL, -- COMMENT 'uuid v4',
  name varchar(36) UNIQUE NOT NULL
);

INSERT INTO teams (id, name) VALUES
('326b83d2-d54e-11ec-b813-0242ac130002',	'Argentina'),
('2dd06ce6-d54e-11ec-b813-0242ac130002',	'Brazil'),
('0f7e5b8e-d54e-11ec-b813-0242ac130002',	'England'),
('fd37ba96-d54d-11ec-b813-0242ac130002',	'France'),
('150690ea-d54e-11ec-b813-0242ac130002',	'Germany'),
('066604ed-d54e-11ec-b813-0242ac130002',	'Italy'),
('1c659f20-d54e-11ec-b813-0242ac130002',	'Netherlands'),
('24f13e0d-d54e-11ec-b813-0242ac130002',	'Portugal'),
('0af805f1-d54e-11ec-b813-0242ac130002',	'Spain'),
('36b09c56-d54e-11ec-b813-0242ac130002',	'Uruguay');

CREATE TABLE parties (
  id varchar(36) PRIMARY KEY NOT NULL, -- COMMENT 'uuid v4',
  home_team varchar(36) NOT NULL,
  away_team varchar(36) NOT NULL,
  score_home_team integer DEFAULT NULL,
  score_away_team integer DEFAULT NULL,
  home_team_rating real NOT NULL DEFAULT 0,
  away_team_rating real NOT NULL DEFAULT 0,
  draft_rating real NOT NULL DEFAULT 0,
  result varchar(1) DEFAULT NULL, -- COMMENT '1 = victory for home_team, D = draw, 2 = victory for away_team',
  date date NOT NULL,
  CONSTRAINT parties_ibfk_1 FOREIGN KEY (home_team) REFERENCES teams (id),
  CONSTRAINT parties_ibfk_2 FOREIGN KEY (away_team) REFERENCES teams (id)
);

INSERT INTO parties (id, home_team, away_team, score_home_team, score_away_team, home_team_rating, away_team_rating, draft_rating, result, date) VALUES
('0e45050f-d54f-11ec-b813-0242ac130002',	'0f7e5b8e-d54e-11ec-b813-0242ac130002',	'fd37ba96-d54d-11ec-b813-0242ac130002',	NULL,	NULL,	1.9,	2.2,	1.7,	NULL,	'2022-05-16'),
('2b33e5a2-d54f-11ec-b813-0242ac130002',	'150690ea-d54e-11ec-b813-0242ac130002',	'066604ed-d54e-11ec-b813-0242ac130002',	NULL,	NULL,	1.8,	2,	2.1,	NULL,	'2022-05-16'),
('5aeb55f9-d54f-11ec-b813-0242ac130002',	'1c659f20-d54e-11ec-b813-0242ac130002',	'24f13e0d-d54e-11ec-b813-0242ac130002',	NULL,	NULL,	1.9,	2.1,	1.8,	NULL,	'2022-05-16'),
('7dc838f7-d54f-11ec-b813-0242ac130002',	'0af805f1-d54e-11ec-b813-0242ac130002',	'36b09c56-d54e-11ec-b813-0242ac130002',	NULL,	NULL,	1.7,	2.2,	2,	NULL,	'2022-05-16'),
('84366cbb-d54f-11ec-b813-0242ac130002',	'326b83d2-d54e-11ec-b813-0242ac130002',	'2dd06ce6-d54e-11ec-b813-0242ac130002',	NULL,	NULL,	1.5,	2,	2.1,	NULL,	'2022-05-16');

CREATE TABLE tickets (
  id varchar(36) PRIMARY KEY NOT NULL, -- COMMENT 'uuid v4',
  date date NOT NULL DEFAULT CURRENT_TIMESTAMP,
  result smallint DEFAULT NULL, -- COMMENT '1 = true / 0 = false',
  bet real NOT NULL DEFAULT 0,
  potentialGain real NOT NULL DEFAULT 0
);

INSERT INTO tickets (id, date, result, bet, potentialGain) VALUES
('a797efee-d54f-11ec-b813-0242ac130002',	'2022-05-16 00:00:00',	0,	3,	0);

CREATE TABLE bets (
  id SERIAL PRIMARY KEY, -- int(11) NOT NULL SERIAL,
  party_id varchar(36) NOT NULL,
  ticket_id varchar(36) NOT NULL,
  pronostic varchar(1) DEFAULT '1', -- COMMENT '1 = victory for home_team, D = draw, 2 = victory for away_team',
  potentialGain real NOT NULL DEFAULT 0,
  result smallint DEFAULT NULL --  COMMENT '0 = false, 1 = true',
);

INSERT INTO bets (id, party_id, ticket_id, pronostic, potentialGain, result) VALUES
(1,	'0e45050f-d54f-11ec-b813-0242ac130002',	'a797efee-d54f-11ec-b813-0242ac130002',	'1',	1.9,	NULL);

ALTER TABLE bets
  ADD CONSTRAINT bets_ibfk_1 FOREIGN KEY (party_id) REFERENCES parties (id);
ALTER TABLE bets
  ADD CONSTRAINT bets_ibfk_2 FOREIGN KEY (ticket_id) REFERENCES tickets (id);




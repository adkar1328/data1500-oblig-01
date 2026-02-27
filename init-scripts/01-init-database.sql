CREATE TABLE bruker (
                        bruker_id SERIAL PRIMARY KEY,
                        navn VARCHAR(100) NOT NULL,
                        telefonnummer VARCHAR(20),
                        epost VARCHAR(100) UNIQUE,
                        registreringsdato DATE NOT NULL
);

CREATE TABLE stasjon (
                         stasjon_id SERIAL PRIMARY KEY,
                         navn VARCHAR(100) NOT NULL,
                         adresse VARCHAR(150),
                         kapasitet INT NOT NULL CHECK (kapasitet > 0)
);

CREATE TABLE sykkel (
                        sykkel_id SERIAL PRIMARY KEY,
                        serienummer VARCHAR(50) UNIQUE NOT NULL,
                        status VARCHAR(20) NOT NULL CHECK (status IN ('ledig','i_bruk','reparasjon')),
                        type VARCHAR(50),
                        innkjopsdato DATE
);

CREATE TABLE leie (
                      leie_id SERIAL PRIMARY KEY,
                      starttid TIMESTAMP NOT NULL,
                      sluttid TIMESTAMP,
                      bruker_id INT REFERENCES bruker(bruker_id),
                      sykkel_id INT REFERENCES sykkel(sykkel_id),
                      startstasjon INT REFERENCES stasjon(stasjon_id),
                      sluttstasjon INT REFERENCES stasjon(stasjon_id)
);

CREATE TABLE betaling (
                          betaling_id SERIAL PRIMARY KEY,
                          belop decimal CHECK (belop >= 0),
                          betalingstidspunkt TIMESTAMP NOT NULL,
                          betalingsmetode VARCHAR(50),
                          leie_id INT REFERENCES leie(leie_id)
);

SELECT 'Database initialisert!' as status;
-- Rolle
CREATE ROLE kunde;

-- Bruker
CREATE USER kunde_1 WITH PASSWORD 'kunde123';

-- Knytt bruker til rolle
GRANT kunde TO kunde_1;

-- Gi lese-tilgang til tabeller
GRANT SELECT ON ALL TABLES IN SCHEMA public TO kunde;

-- Gi tilgang til fremtidige tabeller
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO kunde;

CREATE VIEW kunde_oversikt AS
SELECT bruker_id, navn, epost
FROM bruker;

GRANT CONNECT ON DATABASE oblig01 TO kunde;
GRANT USAGE ON SCHEMA public TO kunde;
GRANT SELECT ON kunde_oversikt TO kunde;



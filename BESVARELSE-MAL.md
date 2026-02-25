# Besvarelse - Refleksjon og Analyse

**Student:** [Adem]

**Studentnummer:** [1328]

**Dato:** [1.03.2026]

---

## Del 1: Datamodellering

### Oppgave 1.1: Entiteter og attributter

**Identifiserte entiteter:**

[Skriv ditt svar her - list opp alle entitetene du har identifisert]
Bruker – Begrunnelse-
Systemet må holde oversikt over hvem som låner sykler. 
Bruker må kunne identifiseres og kontaktes ved problemer eller betaling.
Derfor lagres navn og kontaktinformasjon,
og bruker-ID brukes for å skille brukere fra hverandre.

Sykkel – Begrunnelse-
Hver sykkel må kunne identifiseres individuelt i systemet.
Systemet må vite hvilke sykler som er tilgjengelige,
i bruk eller til reparasjon.
Status og serienummer gjør det mulig å spore og administrere syklene.

Stasjon – Begrunnelse-
Syklene hentes og leveres på ulike stasjoner.
Systemet må vite hvor stasjonene er og hvor mange sykler det er plass til.
Derfor lagres navn, adresse og kapasitet.

Leie – Begrunnelse-
Når en bruker låner en sykkel må turen registreres.
Dette brukes til historikk, oversikt og grunnlag for betaling.
Derfor lagres tidspunkt, bruker, sykkel og start- og sluttstasjon.

Betaling – Begrunnelse-
Systemet må registrere betaling for bruk av syklene.
Dette er nødvendig for økonomisk kontroll og dokumentasjon.
Betalingen kobles til en konkret leietur.





**Attributter for hver entitet:**

[Skriv ditt svar her - list opp attributtene for hver entitet]
Brukere-
Bruker-id, navn, telefonnummer, epost, regissteringsdato.

sykkel-
Sykkel-id, serienummer, status, type, innkjøpsdato.

statsjon-
Stasjon-id, navn, adresse, antall plasser, kapasitet.

leie-
Leie-id, starttid, sluttid, bruker-id, sykkel-id, startstasjon, sluttstatjon.

Betaling-
Betaling-id, beløp, betallingstidpunkt, betalingsmetode, leie-id.

---

### Oppgave 1.2: Datatyper og `CHECK`-constraints

**Valgte datatyper og begrunnelser:**

[Skriv ditt svar her - forklar hvilke datatyper du har valgt for hver attributt og hvorfor]
Bruker-
Bruker-id-INT(brukes som unik identifikator for hver bruker og er derfor et heltall.)
Navn-VARCHAR(navn er tekst og kan variere i lengde.)
Telefonnummer-VARCHAR((+47) og ikke brukes i regning.)
Epost-VARCHAR(e-post er tekst med bokstaver og spesialtegn.)
Registeringsdato-DATE(vi trenger kun dato for når brukeren ble registrert, ikke klokkeslett.)

SYKKEL-
Sykkel-id-INT(unik identifikator for hver sykkel.)
Serienummer-VARCHAR(serienummer kan inneholde både tall og bokstaver.)
Status-VARCHAR(sykkelens tilstand beskrives med tekst (f.eks. ledig, i bruk, reparasjon).)
Type-VARCHAR(sykkeltype er tekst (for eksempel elsykkel eller vanlig sykkel).)
Innkjøpsdato-DATE(datoen sykkelen ble kjøpt inn.)

Stasjon-
Statsjons-id-INT(unik identifikator for hver stasjon.)
Navn-VARCHAR(stasjonsnavn er tekst.)
Adresse-VARCHAR(Adresse inneholder tekst og tall.)
Kapasitet-INT(kapasitet er et antall plasser og må derfor være et heltall.)

Leie-
Leie-id-INT(identifiserer hver leietur.)
Startid-TIMESTAMP(registrerer både dato og klokkeslett når turen starter.)
slutttid-TIMESTAMP(registrerer dato og klokkeslett når turen avsluttes.)
Bruker-id-INT(refererer til hvilken bruker som lånte sykkelen.)
Sykkel-id-INT(Refererer til hvilken sykkel som ble brukt.)
Startastasjon-INT(peker til stasjonen turen startet fra.)
sluttstasjon-INT(peker til stasjonen turen endte på.)

Betaling-
Betaling-id-INT(unik identifikator for betalingen.)
Beløp-DECIMAL(penger kan inneholde desimaler (for eksempel 29.90 kr).)
betalingstidpunkt-TIMESTAMP(registrerer nøyaktig tidspunkt for betaling.)
Betalingsmetode-VARCHAR(tekst som beskriver metode (kort, vipps osv.).)
leie-id-INT(kobler betalingen til en bestemt leietur.)



**`CHECK`-constraints:**

[Skriv ditt svar her - list opp alle CHECK-constraints du har lagt til og forklar hvorfor de er nødvendige]
kapasitet > 0 (en stasjon må ha minst én plass)

beløp > 0 (betaling kan ikke være negativ)

sluttid > starttid (en tur kan ikke slutte før den starter)

status IN ('ledig','i bruk','reparasjon') (bare gyldige sykkelstatuser)

**ER-diagram:**

[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]
erDiagram

    BRUKER ||--o{ LEIE : gjør
    SYKKEL ||--o{ LEIE : brukes_i
    STASJON ||--o{ LEIE : start
    STASJON ||--o{ LEIE : slutt
    LEIE ||--|| BETALING : betales_med

    BRUKER {
        INT bruker_id
        VARCHAR navn
        VARCHAR telefonnummer
        VARCHAR epost
        DATE registreringsdato
    }

    SYKKEL {
        INT sykkel_id
        VARCHAR serienummer
        VARCHAR status
        VARCHAR type
        DATE innkjøpsdato
    }

    STASJON {
        INT stasjon_id
        VARCHAR navn
        VARCHAR adresse
        INT kapasitet
    }

    LEIE {
        INT leie_id
        TIMESTAMP starttid
        TIMESTAMP sluttid
        INT bruker_id
        INT sykkel_id
        INT startstasjon
        INT sluttstasjon
    }

    BETALING {
        INT betaling_id
        DECIMAL beløp
        TIMESTAMP betalingstidspunkt
        VARCHAR betalingsmetode
        INT leie_id
    }

---

### Oppgave 1.3: Primærnøkler

**Valgte primærnøkler og begrunnelser:**
Bruker:
Primærnøkkel: bruker_id
Begrunnelse:Hver bruker må identifiseres unikt i systemet.
Flere brukere kan ha samme navn eller telefonnummer, 
derfor brukes en egen ID for å skille dem.

Sykkel:
Primærnøkkel: sykkel_id
Begrunnelse:Hver sykkel må kunne identifiseres individuelt.
Serienummer kan endres eller registreres feil, derfor brukes en unik ID.

Stasjon:
Primærnøkkel: stasjon_id
Begrunnelse: Flere stasjoner kan ha like navn eller ligge i samme område. 
En egen ID gjør det mulig å referere til riktig stasjon i databasen.

Leie:
Primærnøkkel: leie_id
Begrunnelse: Hver leietur må kunne identifiseres separat for historikk og betaling.
Tidspunkt alene er ikke nok siden flere turer kan starte samtidig.

Betaling:
Primærnøkkel: betaling_id
Begrunnelse: Hver betaling må lagres som en egen registrering 
for økonomisk kontroll og kobles til riktig leietur.

[Skriv ditt svar her - forklar hvilke primærnøkler du har valgt for hver entitet og hvorfor]

**Naturlige vs. surrogatnøkler:**
Dette er valgt fordi naturlige verdier kan endres.
En bruker kan for eksempel bytte telefonnummer eller e-post.
Hvis dette var primærnøkkel ville det skapt problemer i databasen.
En kunstig ID forblir stabil og gjør koblinger mellom tabeller enklere.

[Skriv ditt svar her - diskuter om du har brukt naturlige eller surrogatnøkler og hvorfor]

**Oppdatert ER-diagram:**
BRUKER ||--o{ LEIE : gjør
SYKKEL ||--o{ LEIE : brukes_i
STASJON ||--o{ LEIE : start
STASJON ||--o{ LEIE : slutt
LEIE ||--|| BETALING : betales_med

    BRUKER {
        INT bruker_id
        VARCHAR navn
        VARCHAR telefonnummer
        VARCHAR epost
        DATE registreringsdato
    }

    SYKKEL {
        INT sykkel_id
        VARCHAR serienummer
        VARCHAR status
        VARCHAR type
        DATE innkjøpsdato
    }

    STASJON {
        INT stasjon_id
        VARCHAR navn
        VARCHAR adresse
        INT kapasitet
    }

    LEIE {
        INT leie_id
        TIMESTAMP starttid
        TIMESTAMP sluttid
        INT bruker_id
        INT sykkel_id
        INT startstasjon
        INT sluttstasjon
    }

    BETALING {
        INT betaling_id
        DECIMAL beløp
        TIMESTAMP betalingstidspunkt
        VARCHAR betalingsmetode
        INT leie_id
    }


[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]

---

### Oppgave 1.4: Forhold og fremmednøkler

**Identifiserte forhold og kardinalitet:**
Bruker – Leie (1 til mange)
En bruker kan gjennomføre flere leieturer, men en leietur tilhører kun én bruker.

Sykkel – Leie (1 til mange)
En sykkel kan brukes i mange leieturer over tid, men en leietur gjelder kun én sykkel.

Stasjon – Leie (1 til mange)
En stasjon kan være start- eller sluttpunkt for mange leieturer, men hver leietur har bare én startstasjon og én sluttstasjon.

Leie – Betaling (1 til 1)
Hver leietur har én betaling, og hver betaling hører til én spesifikk leietur.
[Skriv ditt svar her - list opp alle forholdene mellom entitetene og angi kardinalitet]

**Fremmednøkler:**
leie.bruker_id → refererer til bruker.bruker_id
(viser hvilken bruker som lånte sykkelen)

leie.sykkel_id → refererer til sykkel.sykkel_id
(viser hvilken sykkel som ble brukt)

leie.startstasjon → refererer til stasjon.stasjon_id
(viser hvor turen startet)

leie.sluttstasjon → refererer til stasjon.stasjon_id
(viser hvor turen endte)

betaling.leie_id → refererer til leie.leie_id
(kobler betaling til riktig leietur)

[Skriv ditt svar her - list opp alle fremmednøklene og forklar hvordan de implementerer forholdene]

**Oppdatert ER-diagram:**
BRUKER {
INT bruker_id
VARCHAR navn
VARCHAR telefonnummer
VARCHAR epost
DATE registreringsdato
}

    SYKKEL {
        INT sykkel_id
        VARCHAR serienummer
        VARCHAR status
        VARCHAR type
        DATE innkjøpsdato
    }

    STASJON {
        INT stasjon_id
        VARCHAR navn
        VARCHAR adresse
        INT kapasitet
    }

    LEIE {
        INT leie_id
        TIMESTAMP starttid
        TIMESTAMP sluttid
        INT bruker_id
        INT sykkel_id
        INT startstasjon
        INT sluttstasjon
    }

    BETALING {
        INT betaling_id
        DECIMAL beløp
        TIMESTAMP betalingstidspunkt
        VARCHAR betalingsmetode
        INT leie_id
    }




[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]

---

### Oppgave 1.5: Normalisering

**Vurdering av 1. normalform (1NF):**
Datamodellen tilfredsstiller 1NF fordi alle tabeller har en primærnøkkel 
og hvert felt inneholder kun én verdi.
Det finnes ingen kolonner som lagrer flere verdier samtidig,
og alle attributter er atomiske.
For eksempel lagres ett telefonnummer per bruker og
én start- og sluttstasjon per leietur.

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 1NF og hvorfor]

**Vurdering av 2. normalform (2NF):**
Datamodellen tilfredsstiller 2NF fordi alle ikke-nøkkelattributter er fullt avhengige 
av primærnøkkelen. Hver tabell bruker en enkel primærnøkkel (*_id), 
og informasjonen i tabellen beskriver kun den aktuelle entiteten.
For eksempel ligger brukerens navn og e-post kun i brukertabellen og ikke i 
leietabellen.

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 2NF og hvorfor]

**Vurdering av 3. normalform (3NF):**
Datamodellen tilfredsstiller 3NF fordi det ikke finnes transitive avhengigheter. 
Informasjon lagres bare ett sted i databasen. 
Stasjonsinformasjon lagres i stasjonstabellen, brukerdata i brukertabellen og 
betalingsdata i betalingstabellen. Leietabellen inneholder bare referanser til
disse via fremmednøkler og lagrer ikke duplisert informasjon.

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 3NF og hvorfor]

**Eventuelle justeringer:**
Det var ikke nødvendig med større justeringer fordi modellen allerede oppfylte kravene 
til 3NF. Informasjon som kunne blitt duplisert er plassert i egne tabeller,
og relasjoner håndteres med fremmednøkler.

[Skriv ditt svar her - hvis modellen ikke var på 3NF, forklar hvilke justeringer du har gjort]

---

## Del 2: Database-implementering

### Oppgave 2.1: SQL-skript for database-initialisering

**Plassering av SQL-skript:*
-- Sletter tabeller hvis de finnes fra før
DROP TABLE IF EXISTS betaling CASCADE;
DROP TABLE IF EXISTS leie CASCADE;
DROP TABLE IF EXISTS sykkel CASCADE;
DROP TABLE IF EXISTS stasjon CASCADE;
DROP TABLE IF EXISTS bruker CASCADE;

-- =====================
-- TABELLER
-- =====================

CREATE TABLE bruker (
bruker_id SERIAL PRIMARY KEY,
navn VARCHAR(100) NOT NULL,
telefonnummer VARCHAR(20),
epost VARCHAR(100),
registreringsdato DATE NOT NULL
);

CREATE TABLE stasjon (
stasjon_id SERIAL PRIMARY KEY,
navn VARCHAR(100) NOT NULL,
adresse VARCHAR(150),
kapasitet INT CHECK (kapasitet > 0)
);

CREATE TABLE sykkel (
sykkel_id SERIAL PRIMARY KEY,
serienummer VARCHAR(50) NOT NULL,
status VARCHAR(20) CHECK (status IN ('ledig','i bruk','reparasjon')),
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
sluttstasjon INT REFERENCES stasjon(stasjon_id),
CHECK (sluttid IS NULL OR sluttid > starttid)
);

CREATE TABLE betaling (
betaling_id SERIAL PRIMARY KEY,
belop DECIMAL(6,2) CHECK (belop > 0),
betalingstidspunkt TIMESTAMP NOT NULL,
betalingsmetode VARCHAR(50),
leie_id INT UNIQUE REFERENCES leie(leie_id)
);

-- =====================
-- TESTDATA
-- =====================

-- Brukere
INSERT INTO bruker (navn, telefonnummer, epost, registreringsdato) VALUES
('Ola Nordmann', '+4790000000', 'ola@email.no', '2024-01-10'),
('Kari Hansen', '+4791111111', 'kari@email.no', '2024-02-15'),
('Per Olsen', '+4792222222', 'per@email.no', '2024-03-20');

-- Stasjoner
INSERT INTO stasjon (navn, adresse, kapasitet) VALUES
('Sentrum', 'Storgata 1', 10),
('Jernbanetorget', 'Jernbanetorget 5', 15),
('Universitetet', 'Universitetsgata 20', 12);

-- Sykler
INSERT INTO sykkel (serienummer, status, type, innkjopsdato) VALUES
('SYK001', 'ledig', 'Vanlig', '2023-05-01'),
('SYK002', 'ledig', 'Elsykkel', '2023-05-02'),
('SYK003', 'reparasjon', 'Vanlig', '2023-05-03'),
('SYK004', 'ledig', 'Elsykkel', '2023-05-04');

-- Leie
INSERT INTO leie (starttid, sluttid, bruker_id, sykkel_id, startstasjon, sluttstasjon) VALUES
('2024-04-01 10:00:00', '2024-04-01 10:25:00', 1, 1, 1, 2),
('2024-04-02 12:00:00', '2024-04-02 12:40:00', 2, 2, 2, 3);

-- Betaling
INSERT INTO betaling (belop, betalingstidspunkt, betalingsmetode, leie_id) VALUES
(29.90, '2024-04-01 10:30:00', 'Kort', 1),
(39.90, '2024-04-02 12:45:00', 'Vipps', 2);



[Bekreft at du har lagt SQL-skriptet i `init-scripts/01-init-database.sql`]
SQL-skriptet er plassert i init-scripts/01-init-database.sql.

**Antall testdata:**

- Kunder: [3]
- Sykler: [4]
- Sykkelstasjoner: [3]
- Låser: [0]
- Utleier: [0]

---

### Oppgave 2.2: Kjøre initialiseringsskriptet

**Dokumentasjon av vellykket kjøring:**
Databasen startet uten feil. 
Terminalen viste meldingen 
"database system is ready to accept connections"
og SQL-initialiseringsskriptet ble kjørt automatisk.
[Skriv ditt svar her - f.eks. skjermbilder eller output fra terminalen som viser at databasen ble opprettet uten feil]
Databasen startet uten feil ved kjøring av `docker compose up`.
Terminalen viste meldingen *"database system is ready to accept connections"*.
Initialiseringsskriptet `01-init-database.sql` ble kjørt automatisk, noe som bekreftes av meldingen *"Database initialisert!"* i loggen.


**Spørring mot systemkatalogen:**

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

**Resultat:**
betaling
bruker
leie
stasjon
sykkel


```
[Skriv resultatet av spørringen her - list opp alle tabellene som ble opprettet]
```

---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

```sql
[Skriv din SQL-kode for å opprette rollen 'kunde' her]
CREATE ROLE kunde;
```

**SQL for å opprette bruker:**

```sql
[Skriv din SQL-kode for å opprette brukeren 'kunde_1' her]
CREATE USER kunde_1 WITH PASSWORD 'kunde123';
GRANT kunde TO kunde_1;
```

**SQL for å tildele rettigheter:**

```sql
[Skriv din SQL-kode for å tildele rettigheter til rollen her]
-- Gi tilgang til å bruke databasen
GRANT CONNECT ON DATABASE oblig01 TO kunde;

-- Gi tilgang til schema
GRANT USAGE ON SCHEMA public TO kunde;

-- Kan lese data
GRANT SELECT ON ALL TABLES IN SCHEMA public TO kunde;

-- Kan registrere leie og betaling
GRANT INSERT ON leie TO kunde;
GRANT INSERT ON betaling TO kunde;
```

---

### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

```sql
[Skriv din SQL-kode for VIEW her]
CREATE VIEW kunde_oversikt AS
SELECT
    leie.leie_id,
    leie.starttid,
    leie.sluttid,
    sykkel.sykkel_id,
    stasjon.navn AS startstasjon,
    stasjon.adresse
FROM leie
         JOIN sykkel ON leie.sykkel_id = sykkel.sykkel_id
         JOIN stasjon ON leie.startstasjon = stasjon.stasjon_id;
```

**Ulempe med VIEW vs. POLICIES:**

[Skriv ditt svar her - diskuter minst én ulempe med å bruke VIEW for autorisasjon sammenlignet med POLICIES]
En ulempe med å bruke VIEW i stedet for POLICIES er at sikkerheten bare gjelder gjennom selve viewet.
Hvis brukeren får direkte tilgang til de originale tabellene,
kan de fortsatt lese alle data.
POLICIES (row-level security) begrenser derimot tilgang direkte i tabellen 
og er derfor sikrere, siden regler håndheves uansett hvordan tabellen aksesseres.
---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**
Høysesong: 20000 × 5 måneder = 100000
Mellomsesong: 5000 × 4 måneder = 20000
Lavsesong: 500 × 3 måneder = 1500

Totalt antall utleier per år:
100000 + 20000 + 1500 = 121500 utleier per år


**Estimat for lagringskapasitet:**
Leie-tabellen lagrer alle utleier og er derfor størst.
En rad i leie-tabellen er omtrent 36 byte.
121500 utleier per år gir ca 4,3 MB lagring.

Betaling-tabellen får omtrent samme antall rader og bruker ca 3,6 MB.

Bruker-tabellen (ca. 10 000 brukere) gir ca 1,2 MB.
Sykkel-tabellen (ca. 2000 sykler) gir ca 0,16 MB.
Stasjon-tabellen (ca. 100 stasjoner) gir ca 0,01 MB.

**Totalt for første år:**
Totalt estimert lagringsbehov første år er omtrent 9–10 MB.
Dette er lite for en database, og systemet kan lagre mange års historikk uten lagringsproblemer.

---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**

I en CSV-fil lagres all informasjon på hver rad.
Det betyr at samme informasjon gjentas mange ganger.
For eksempel vil navn, telefonnummer 
og e-post til samme bruker stå oppført i hver eneste utleie personen gjør.
Også stasjonsnavn og adresse vil bli repetert for hver tur som starter på samme sted.
Dette skaper redundans fordi identisk informasjon lagres flere ganger i stedet for én gang.


**Problem 2: Inkonsistens**
Redundans kan føre til inkonsistens.
Hvis en bruker endrer telefonnummer eller e-post,
må alle radene i CSV-filen oppdateres manuelt. 
Hvis noen rader ikke blir oppdatert,
vil filen inneholde flere forskjellige telefonnumre for samme person.
Det samme kan skje med stasjoner 
– hvis en adresse endres kan noen rader ha gammel adresse og andre ny,
noe som gjør dataene upålitelige.

**Problem 3: Oppdateringsanomalier**
En flat fil kan få flere typer oppdateringsanomalier:

Sletteanomali: Hvis man sletter den eneste raden som inneholder en bestemt stasjon eller bruker, mister man også all informasjon om den, selv om den fortsatt eksisterer.

Innsettingsanomali: Man kan ikke registrere en ny bruker før brukeren faktisk har gjort en utleie, fordi CSV-filen kun lagrer utleier.

Oppdateringsanomali: Hvis man oppdaterer informasjon, for eksempel e-postadresse, må alle forekomster endres. Hvis noen glemmes blir dataene inkonsistente.


**Fordeler med en indeks:**

En indeks gjør det mulig å finne rader raskere uten å lese hele tabellen.
I stedet for å gå gjennom alle utleier én etter én kan databasen
slå opp direkte i indeksen og finne riktig rad nesten umiddelbart.
Dette reduserer antall diskoperasjoner og gjør spørringer mye raskere.


**Case 1: Indeks passer i RAM**
Hvis indeksen får plass i RAM kan databasen slå opp informasjon direkte i minnet. 
Tilgang til RAM er svært rask sammenlignet med disk,
så databasen slipper å lese fra harddisken for hver spørring.
Resultatet er svært korte responstider og høy ytelse.


**Case 2: Indeks passer ikke i RAM**

Hvis indeksen er større enn tilgjengelig RAM må databasen lese deler av den fra disk.
For å håndtere store datamengder kan flettesortering brukes.
Data deles først opp i mindre sorterte deler som passer i minnet,
og deretter flettes disse delene sammen til en fullstendig sortert struktur.
Dette gjør det mulig å håndtere store datasett selv om alt ikke får plass i minnet samtidig.


**Datastrukturer i DBMS:**

Databaser bruker ofte B+-trær og hash-indekser.
B+-trær er gode for søk på intervaller og sorterte data fordi noder er organisert 
hierarkisk og kan leses effektivt fra disk.
Hash-indekser er raskere for eksakte oppslag, 
siden en hash-funksjon beregner direkte hvor data ligger,
men de fungerer dårlig for intervallsøk.
Derfor brukes B+-trær vanligvis som standardindeks i relasjonsdatabaser.


---

### Oppgave 4.3: Datastrukturer for logging

**Foreslått datastruktur:**
LSM-tree (Log-Structured Merge Tree)

**Begrunnelse:**
Et loggsystem består hovedsakelig av kontinuerlige innskrivinger av nye hendelser.
Data legges til fortløpende og blir sjelden endret eller slettet.
En LSM-tree er laget nettopp for slike arbeidsmengder,
fordi den optimaliserer sekvensielle skriveoperasjoner og reduserer antall diskoperasjoner.
Derfor passer den godt til logging av hendelser i et bysykkelsystem.


**Skrive-operasjoner:**
LSM-tree er svært effektiv for skriveoperasjoner fordi nye data først lagres i minnet 
(memtable) og deretter skrives sekvensielt til disk. 
Sekvensielle diskoperasjoner er mye raskere enn tilfeldige oppslag.
Systemet slipper derfor hyppige diskoppdateringer,
noe som gir høy skriveytelse når mange hendelser logges kontinuerlig.

**Lese-operasjoner:**

Lesing skjer sjeldnere i et loggsystem, og
LSM-tree håndterer dette ved å slå opp i både minnet og
de lagrede filene på disk.
Selv om lesing kan være noe tregere enn i et B+-tre,
er dette akseptabelt fordi loggdata hovedsakelig skrives og 
bare av og til leses for analyse eller feilsøking.

---

### Oppgave 4.4: Validering i flerlags-systemer

**Hvor bør validering gjøres:**

Validering bør gjøres i flere lag i systemet: nettleseren,
applikasjonslaget og databasen.
Hvert lag har ulike oppgaver og beskytter systemet på forskjellige måter.
Ved å validere i flere lag får man både bedre brukeropplevelse og høyere sikkerhet.

**Validering i nettleseren:**
Validering i nettleseren skjer før data sendes til serveren, for eksempel ved å sjekke at e-post har riktig format eller at et felt ikke er tomt.

Fordeler:

* Brukeren får rask tilbakemelding
* Mindre trafikk til serveren
* Bedre brukeropplevelse

Ulemper:

* Kan omgås ved å manipulere forespørsler
* Gir ikke sikkerhet alene siden klienten ikke er til å stole på


**Validering i applikasjonslaget:**

Applikasjonslaget validerer data på serversiden før det lagres i databasen.

Fordeler:

Gir bedre sikkerhet enn nettleservalidering

Kan håndtere mer avanserte regler, som sjekk av brukertillatelser

Hindrer ugyldige forespørsler fra å nå databasen

Ulemper:

Brukeren får ikke like umiddelbar tilbakemelding som i nettleseren

Krever mer behandling på serveren

**Validering i databasen:**

Databasen kan validere data gjennom constraints som NOT NULL, CHECK og FOREIGN KEY.

Fordeler:

* Garanterer dataintegritet
* Hindrer at ugyldige data lagres, uansett hvordan databasen nås
* Beskytter mot programmeringsfeil i applikasjonen

Ulemper:

* Feilmeldinger kan være mindre brukervennlige
* Endringer kan være vanskeligere å håndtere uten å påvirke databasen


**Konklusjon:**

Den beste løsningen er å bruke validering i alle lag.
Nettleseren gir rask tilbakemelding til brukeren,
applikasjonslaget gir sikkerhet og kontroll,
og databasen sikrer at data alltid er gyldige.
Sammen gir dette både god brukeropplevelse og høy datasikkerhet.


---

### Oppgave 4.5: Refleksjon over læringsutbytte

**Hva har du lært så langt i emnet:**

Så langt i emnet har jeg lært grunnleggende konsepter innen databaser, 
blant annet ER-modellering, entiteter, attributter og relasjoner. 
Jeg har også lært hvordan man normaliserer en database for å unngå redundans 
og inkonsistente data.
I tillegg har jeg fått erfaring med SQL,
blant annet å opprette tabeller, bruke primærnøkler og fremmednøkler,
samt skrive enkle spørringer.


**Hvordan har denne oppgaven bidratt til å oppnå læringsmålene:**

Oppgaven har gjort det mulig å anvende teorien i praksis.
Ved å designe et bysykkelsystem fra bunnen av måtte jeg først modellere systemet,
deretter implementere databasen og til slutt hente ut data ved hjelp av SQL.
Dette ga en bedre forståelse av hvordan databaser brukes i virkelige systemer
og hvordan ulike deler av pensum henger sammen.


Se oversikt over læringsmålene i en PDF-fil i Canvas https://oslomet.instructure.com/courses/33293/files/folder/Plan%20v%C3%A5ren%202026?preview=4370886

**Hva var mest utfordrende:**
Det mest utfordrende var å sette opp databasen og få Docker, PostgreSQL og
IntelliJ til å fungere sammen.
Det var også krevende å forstå hvordan init-skriptet fungerte og
hvorfor databasen måtte opprettes på nytt for at endringer skulle gjelde. 
Når oppsettet først fungerte ble resten av oppgaven betydelig enklere.


**Hva har du lært om databasedesign:**
Jeg har lært at databasedesign er viktig for å unngå problemer senere.
Ved å dele informasjon opp i flere tabeller 
og bruke fremmednøkler unngår man duplisering av data. 
Normalisering gjør databasen mer strukturert og lettere å vedlikeholde.
Jeg har også forstått hvorfor man bør planlegge modellen nøye før man begynner å programmere.


---

## Del 5: SQL-spørringer og Automatisk Testing

**Plassering av SQL-spørringer:**

[Bekreft at du har lagt SQL-spørringene i `test-scripts/queries.sql`]
SQL-spørringene er lagt i filen `test-scripts/queries.sql` i prosjektmappen.



**Eventuelle feil og rettelser:**

[Skriv ditt svar her - hvis noen tester feilet, forklar hva som var feil og hvordan du rettet det]
Under arbeidet oppstod det feil knyttet til oppsett av databasen og initialiseringsskriptet.
Problemet var at tabellene ikke ble opprettet fordi `01-init-database.sql` 
ikke inneholdt CREATE TABLE-setninger, og databasen måtte slettes og opprettes på nytt med 
`docker compose down -v` før endringene tok effekt.
Etter at tabellene ble riktig definert og databasen startet på nytt fungerte testene som forventet.


---

## Del 6: Bonusoppgaver (Valgfri)

### Oppgave 6.1: Trigger for lagerbeholdning

**SQL for trigger:**

```sql
[Skriv din SQL-kode for trigger her, hvis du har løst denne oppgaven]
```

**Forklaring:**

[Skriv ditt svar her - forklar hvordan triggeren fungerer]

**Testing:**

[Skriv ditt svar her - vis hvordan du har testet at triggeren fungerer som forventet]

---

### Oppgave 6.2: Presentasjon

**Lenke til presentasjon:**

[Legg inn lenke til video eller presentasjonsfiler her, hvis du har løst denne oppgaven]

**Hovedpunkter i presentasjonen:**

[Skriv ditt svar her - oppsummer de viktigste punktene du dekket i presentasjonen]

---

**Slutt på besvarelse**

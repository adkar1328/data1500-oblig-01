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

[Skriv ditt svar her - forklar hvilke primærnøkler du har valgt for hver entitet og hvorfor]

**Naturlige vs. surrogatnøkler:**

[Skriv ditt svar her - diskuter om du har brukt naturlige eller surrogatnøkler og hvorfor]

**Oppdatert ER-diagram:**

[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]

---

### Oppgave 1.4: Forhold og fremmednøkler

**Identifiserte forhold og kardinalitet:**

[Skriv ditt svar her - list opp alle forholdene mellom entitetene og angi kardinalitet]

**Fremmednøkler:**

[Skriv ditt svar her - list opp alle fremmednøklene og forklar hvordan de implementerer forholdene]

**Oppdatert ER-diagram:**

[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]

---

### Oppgave 1.5: Normalisering

**Vurdering av 1. normalform (1NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 1NF og hvorfor]

**Vurdering av 2. normalform (2NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 2NF og hvorfor]

**Vurdering av 3. normalform (3NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 3NF og hvorfor]

**Eventuelle justeringer:**

[Skriv ditt svar her - hvis modellen ikke var på 3NF, forklar hvilke justeringer du har gjort]

---

## Del 2: Database-implementering

### Oppgave 2.1: SQL-skript for database-initialisering

**Plassering av SQL-skript:**

[Bekreft at du har lagt SQL-skriptet i `init-scripts/01-init-database.sql`]

**Antall testdata:**

- Kunder: [antall]
- Sykler: [antall]
- Sykkelstasjoner: [antall]
- Låser: [antall]
- Utleier: [antall]

---

### Oppgave 2.2: Kjøre initialiseringsskriptet

**Dokumentasjon av vellykket kjøring:**

[Skriv ditt svar her - f.eks. skjermbilder eller output fra terminalen som viser at databasen ble opprettet uten feil]

**Spørring mot systemkatalogen:**

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

**Resultat:**

```
[Skriv resultatet av spørringen her - list opp alle tabellene som ble opprettet]
```

---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

```sql
[Skriv din SQL-kode for å opprette rollen 'kunde' her]
```

**SQL for å opprette bruker:**

```sql
[Skriv din SQL-kode for å opprette brukeren 'kunde_1' her]
```

**SQL for å tildele rettigheter:**

```sql
[Skriv din SQL-kode for å tildele rettigheter til rollen her]
```

---

### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

```sql
[Skriv din SQL-kode for VIEW her]
```

**Ulempe med VIEW vs. POLICIES:**

[Skriv ditt svar her - diskuter minst én ulempe med å bruke VIEW for autorisasjon sammenlignet med POLICIES]

---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**

[Skriv din utregning her]

**Estimat for lagringskapasitet:**

[Skriv din utregning her - vis hvordan du har beregnet lagringskapasiteten for hver tabell]

**Totalt for første år:**

[Skriv ditt estimat her]

---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**

[Skriv ditt svar her - gi konkrete eksempler fra CSV-filen som viser redundans]

**Problem 2: Inkonsistens**

[Skriv ditt svar her - forklar hvordan redundans kan føre til inkonsistens med eksempler]

**Problem 3: Oppdateringsanomalier**

[Skriv ditt svar her - diskuter slette-, innsettings- og oppdateringsanomalier]

**Fordeler med en indeks:**

[Skriv ditt svar her - forklar hvorfor en indeks ville gjort spørringen mer effektiv]

**Case 1: Indeks passer i RAM**

[Skriv ditt svar her - forklar hvordan indeksen fungerer når den passer i minnet]

**Case 2: Indeks passer ikke i RAM**

[Skriv ditt svar her - forklar hvordan flettesortering kan brukes]

**Datastrukturer i DBMS:**

[Skriv ditt svar her - diskuter B+-tre og hash-indekser]

---

### Oppgave 4.3: Datastrukturer for logging

**Foreslått datastruktur:**

[Skriv ditt svar her - f.eks. heap-fil, LSM-tree, eller annen egnet datastruktur]

**Begrunnelse:**

**Skrive-operasjoner:**

[Skriv ditt svar her - forklar hvorfor datastrukturen er egnet for mange skrive-operasjoner]

**Lese-operasjoner:**

[Skriv ditt svar her - forklar hvordan datastrukturen håndterer sjeldne lese-operasjoner]

---

### Oppgave 4.4: Validering i flerlags-systemer

**Hvor bør validering gjøres:**

[Skriv ditt svar her - argumenter for validering i ett eller flere lag]

**Validering i nettleseren:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i applikasjonslaget:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i databasen:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Konklusjon:**

[Skriv ditt svar her - oppsummer hvor validering bør gjøres og hvorfor]

---

### Oppgave 4.5: Refleksjon over læringsutbytte

**Hva har du lært så langt i emnet:**

[Skriv din refleksjon her - diskuter sentrale konsepter du har lært]

**Hvordan har denne oppgaven bidratt til å oppnå læringsmålene:**

[Skriv din refleksjon her - koble oppgaven til læringsmålene i emnet]

Se oversikt over læringsmålene i en PDF-fil i Canvas https://oslomet.instructure.com/courses/33293/files/folder/Plan%20v%C3%A5ren%202026?preview=4370886

**Hva var mest utfordrende:**

[Skriv din refleksjon her - diskuter hvilke deler av oppgaven som var mest krevende]

**Hva har du lært om databasedesign:**

[Skriv din refleksjon her - reflekter over prosessen med å designe en database fra bunnen av]

---

## Del 5: SQL-spørringer og Automatisk Testing

**Plassering av SQL-spørringer:**

[Bekreft at du har lagt SQL-spørringene i `test-scripts/queries.sql`]


**Eventuelle feil og rettelser:**

[Skriv ditt svar her - hvis noen tester feilet, forklar hva som var feil og hvordan du rettet det]

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

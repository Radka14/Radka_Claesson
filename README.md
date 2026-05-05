**SQL Projekt – Analýza mezd, cen potravin a HDP**

**Úvod**



Tento projekt se zabývá analýzou vývoje mezd, cen potravin a hrubého domácího produktu (HDP) v České republice v letech 2006–2018.

Cílem je zjistit, jak se tyto ukazatele vyvíjejí v čase, jak spolu souvisejí a jak ovlivňují kupní sílu obyvatel.



**Použitá data**



Projekt vychází z dat obsahujících:



průměrné mzdy v jednotlivých odvětvích

ceny vybraných potravin

makroekonomické ukazatele (HDP)



Data byla upravena a spojena do dvou hlavních tabulek:



primární tabulka (mzdy a ceny potravin)

sekundární tabulka (HDP a další ekonomické ukazatele)

Tvorba tabulek



Tabulky byly vytvořeny pomocí SQL skriptů:



create\_primary\_table.sql

create\_secondary\_table.sql



Při jejich tvorbě byly využity:



JOIN operace pro propojení dat

Common Table Expressions (CTE)

window funkce pro výpočty meziročních změn



**Výzkumné otázky**

**## 1. Rostou mzdy ve všech odvětvích, nebo v některých klesají?**



Pro analýzu byl použit SQL skript `vyzkumna_otazka_1.sql`, který sleduje meziroční změny průměrných mezd v jednotlivých odvětvích v letech 2006–2018. Pro výpočet byl použit LAG funkce, která umožňuje porovnání mezd mezi jednotlivými roky.



\---



\### Výsledek:



Ve většině odvětví mzdy v dlouhodobém horizontu rostou.  

Zároveň se však v téměř všech odvětvích objevují jednotlivé roky, kdy mzdy dočasně klesají.



\---



\### Konkrétní zjištění:



\- Nejčastější poklesy mezd se objevují zejména v roce \*\*2013\*\*, případně v ekonomicky slabších obdobích.

\- Mezi odvětví s výraznějšími poklesy patří například:

&#x20; - \*\*Peněžnictví a pojišťovnictví\*\* (2013: -8,83 %)

&#x20; - \*\*Těžba a dobývání\*\* (více poklesů např. 2009, 2013, 2014, 2016)

&#x20; - \*\*Profesní, vědecké a technické činnosti\*\* (2010 a 2013)

&#x20; - \*\*Stavebnictví\*\* (2013)

&#x20; - \*\*Ubytování, stravování a pohostinství\*\* (např. 2009, 2011)



\- Naopak některá odvětví vykazují téměř stabilní růst:

&#x20; - \*\*Ostatní činnosti\*\*

&#x20; - \*\*Doprava a skladování\*\*

&#x20; - \*\*Informační a komunikační činnosti\*\*



\---



\### Interpretace:



Vývoj mezd v České republice je dlouhodobě rostoucí, avšak není stabilní v každém roce.  

Krátkodobé poklesy jsou přítomné ve většině odvětví a pravděpodobně souvisí s ekonomickými výkyvy (např. dopady hospodářského zpomalení kolem roku 2013).



\---



\### Závěr:



Mzdy nerostou ve všech odvětvích nepřetržitě.  

Většina odvětví vykazuje dlouhodobý růst, ale téměř každé odvětví obsahuje alespoň jeden rok poklesu mezd.



**### 2. Kolik je možné si koupit litrů mléka a kilogramů chleba?**



Pro výpočet kupní síly byla použita průměrná mzda a průměrné ceny vybraných potravin v prvním (2006) a posledním (2018) sledovaném období. Analýza byla provedena pomocí SQL skriptu `vyzkumna_otazka_2.sql`.



\#### Výpočet:

> počet kusů = průměrná mzda / průměrná cena produktu



\#### Výsledek:



| Rok  | Produkt | Jednotka | Průměrná mzda | Průměrná cena | Počet kusů |

|------|--------|----------|---------------|---------------|------------|

| 2006 | Chléb konzumní kmínový | kg | 21165.18 | 16.12 | 1312.68 |

| 2006 | Mléko polotučné pasterované | l | 21165.18 | 14.44 | 1465.95 |

| 2018 | Chléb konzumní kmínový | kg | 33091.45 | 24.24 | 1365.24 |

| 2018 | Mléko polotučné pasterované | l | 33091.45 | 19.82 | 1669.80 |



\#### Interpretace:

I když mzdy v období 2006–2018 výrazně vzrostly, současně došlo i ke zvýšení cen potravin.

To znamená, že růst reálné kupní síly nebyl tak výrazný, jak by odpovídalo samotnému růstu mezd.



\- V roce 2018 si bylo možné dovolit více mléka i chleba než v roce 2006.

\- Růst kupní síly je však částečně tlumen růstem cen potravin.



\#### Závěr:

Kupní síla obyvatel České republiky se mezi lety 2006 a 2018 zvýšila, ale neúměrný růst cen potravin tento efekt částečně zpomalil.



**3. Která kategorie potravin zdražuje nejpomaleji?**



Pro analýzu byl použit SQL skript `vyzkumna_otazka_3.sql`.  

Byl vypočítán průměrný meziroční procentuální růst cen jednotlivých potravinových kategorií v celém sledovaném období.  

Výpočet vychází z porovnání průměrné roční ceny a jejího vývoje v čase pomocí funkce LAG.



\---



\### Výsledek:



Nejpomaleji zdražující kategorií potravin je:



\*\*Cukr krystalový (-1,92 %)\*\*



\---



\### Interpretace:



\- Cukr krystalový je jedinou sledovanou kategorií, u které dochází v průměru k poklesu cen v čase.

\- Průměrný meziroční růst je záporný (-1,92 %), což znamená dlouhodobé zlevňování této komodity.

\- Oproti ostatním potravinám je tato kategorie cenově nejstabilnější a vykazuje opačný trend než většina potravin.



\---



\### Závěr:



Nejpomaleji zdražující kategorií potravin je cukr krystalový, protože jako jediný vykazuje záporný průměrný meziroční růst cen.



**4. Existuje rok, kdy ceny potravin rostly výrazně rychleji než mzdy (o více než 10 %)?**



Pro analýzu byl porovnán meziroční vývoj průměrných mezd a průměrných cen potravin v jednotlivých letech v období 2006–2018.  

Výpočet byl proveden pomocí LAG funkce, která umožňuje sledovat meziroční změny.



Následně byl vypočítán rozdíl mezi růstem cen potravin a růstem mezd.



\---



\### Výsledek:



Na základě provedené analýzy:



\*\*nebyl identifikován žádný rok, ve kterém by růst cen potravin převýšil růst mezd o více než 10 procentních bodů.\*\*



\---



\### Doplňující zjištění:



\- V některých letech rostly mzdy rychleji než ceny (např. 2007, 2008, 2014, 2015, 2016, 2018).

\- V jiných letech rostly ceny rychleji než mzdy (např. 2011, 2012, 2013, 2017).

\- Významnější rozdíly mezi růstem cen a mezd se objevují spíše výjimečně, ale nepřesahují hranici 10 procentních bodů.



\---



\### Interpretace:



Vývoj mezd a cen potravin je dlouhodobě relativně vyrovnaný.  

I když v jednotlivých letech dochází k rozdílům ve vývoji, neexistuje období, kdy by ceny potravin dramaticky převyšovaly růst mezd.



\---



\### Závěr:



Hypotéza o výrazném rozdílu (více než 10 p. b.) mezi růstem cen potravin a růstem mezd nebyla potvrzena.





**5. Má výška HDP vliv na změny ve mzdách a cenách potravin?**



Pro analýzu byl porovnán vývoj HDP, mezd a průměrných cen potravin v letech 2006–2018.  

Data byla propojena pomocí SQL JOIN a následně byly vypočítány meziroční procentuální změny jednotlivých ukazatelů pomocí LAG funkce.



Cílem bylo zjistit, zda růst HDP souvisí s vývojem mezd a cen potravin.



\---



\### Výsledek:



\- Růst HDP je ve sledovaném období obecně doprovázen růstem mezd.

\- Vztah mezi HDP a cenami potravin je méně stabilní a méně jednoznačný.

\- Neexistuje jednoznačný okamžitý vztah mezi HDP a cenami potravin.



\---



\### Doplňující zjištění:



\- Nejvýraznější růst HDP je spojen s růstem mezd (např. 2017–2018).

\- V některých letech (např. 2009) dochází k poklesu HDP, který se částečně promítá i do vývoje mezd.

\- Ceny potravin vykazují nižší stabilitu a jejich vývoj není přímo úměrný HDP.



\---



\### Interpretace:



Ekonomický růst (HDP) má pozitivní vliv zejména na mzdy, avšak tento vztah není okamžitý a vždy přímý.  

Ceny potravin jsou ovlivněny více faktory (např. inflace, náklady výroby, tržní výkyvy), a proto jejich vztah k HDP není jednoznačný.



\---



\### Závěr:



Mezi HDP a mzdami existuje částečná pozitivní korelace.  

Vliv HDP na ceny potravin je však slabší a méně konzistentní.


# MASQUERADE - fork na wewnętrzne potrzeby

## Spis treści
* [Opis projektu](#description)
* [Makefile](#makefile)
* [Przykład użycia](#usecase)


## <a id="description" />Opis projektu
**MASQUERADE** jest oprogramowanie służącym do anonimizowania zawartości w bazach danych. Dokładnniejszy opis całego
rozwiązania jest dostępny w pliku README.md w głównym katalogu projektu. Tutaj ograniczymy się jedynie do opisania
możliwości, o które rozszerzyliśmy oryginalny projekt.

## <a id="makefile" /> Makefile
Praktycznie cała dodana przez nas funkcjonalność sprowadza się do obsługi dockera przez plik Makefile, który umożliwia
wykonanie następujących czynności:
### up - uruchamanie środowiska
Buduje obrazy i uruchamia kontenery przy pomocy docker-compose
```bash
make up
```

### down - zatrzymanie środowiska
Zatrzymuje kontenery i usuwa podpięte do nich wolumeny
```bash
make down
```

### bash-database - wejście do kontenera z bazą danych
```bash
make bash-database
```

### drop-database-mysql - usunięcie wskazanej bazy danych
```bash
make drop-database-mysql database=[nazwa_bazy_danych_ktora_chcemy_usunac]
```

### create-database-mysql - tworzy bazę danych
```bash
make create-database-mysql database=[nazwa_bazy_danych_ktora_chcemy_utworzyc]
```

### import-mysql - importuje dane z pliku do bazy danych
**Uwaga!** Jeżeli bazad danych o podanej nazwie nie istnieje, zostanie ona usunięta
```bash
make import-mysql database=[nazwa_bazy_danych_do_ktorej_chcemy_importowac] sqlfile=[nazwa_pliku_z_danymi]
```

### anonymize-mysql - anonimizuje dane w bazie danych
```bash
make anonymize-mysql database=[nazwa_bazy_danych_ktora_chcemy_anonimizowac] platform=[nazwa_platformy]
```

### dump-mysql - zrzuca dane z bazy danych do pliku
```bash
make dump-mysql database=[nazwa_bazy_danych_z_ktorej_chcemy_zrzucac] sqlfile=[nazwa_pliku_do_ktorego_chcemy_zrzucac]
```

### anonymize-file-mysql - anonimizuje dane w pliku
```bash
make anonymize-mysql database=[nazwa_bazy_danych_uzywanej_w_procesie_anonimizacji] sqlfile=[nazwa_pliku_sql_d anonimizacji] platform=[nazwa_platformy]
```

## <a id="usecase" /> Przykład użycia
Załóżmy, że mamy bazę danych w pliku `database.sql`, zawierający bazę danych z Magento, i chcemy go zanonimizować. 
W tym celu wykonujemy następujące kroki:
1. Kopiujemy plik do katalogu `data` (jeżeli katalog nie istnieje, należy go utworzyć)
2. Uruchamiamy środowisko
```bash
make up
```
3. Anonimizujemy plik:
```bash
make dump-mysql database=example_database sqlfile=database.sql platform=magento
```
4. Zanonimizowana baza zostanie utworzona w pliku `data/anonymized_database.sql`
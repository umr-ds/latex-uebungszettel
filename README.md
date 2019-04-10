# LaTeX basierte Übungszettel

Dieses Framework dient zur Generierung von LaTeX-basierten Übungszetteln. Aufgaben und ihre Ressourcen werden in einzelnen Ordnern bzw. Dateien verwaltet und können so insbesondere mit gängigen Versionsverwaltungstools erfasst werden.

## Aufbau

- **aufgaben/\*/\*.tex**: Aufgabenstellungen komplexerer Aufgaben
- **source/u\*.tex**: Definition eines Übungszettels - Datum der Abgabe, Aufgaben, ...
- **base/\***: Definition der Klasse
- **u\*.pdf**: Erzeugte Übungszettel
- **loesungen/l\*.pdf**: Aus den Übungen generierte Lösungszettel

## Makefile Targets

- **all**: erzeugt Übungen, Lösungen und Aufgaben
- **clean**: löscht erzeugte Dateien
- **uebungen**
- **loesungen**
- **aufgaben**
- **u\*.pdf**: einzelner Übungszettel
- **loesungen/l\*.pdf**: einzelner Lösungszettel
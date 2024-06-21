#!/bin/bash

mkdir -p _templates

touch _templates/datei-1.txt
touch _templates/datei-2.docx
touch _templates/datei-3.pdf


mkdir -p _schulklassen

cat > _schulklassen/AP22b.txt <<EOL
Amherd
Baume
Keller
Arslan
Buehler
Camenisch
Dubach
Eberle
Fischer
Grob
Hofmann
Iseli
EOL

cat > _schulklassen/M122-AP22c.txt <<EOL
Arslan
Buehler
Camenisch
Dubach
Eberle
Fischer
Grob
Hofmann
Iseli
Jung
Kunz
Lehmann
EOL
cat > _schulklassen/M122-AP22d.txt <<EOL
Gautham
Ori
Tim
David
Matthew
Leon
Levin
Albaraa
Ronny
Batthuan
Leart
Muhammad
EOL
echo "Vorlagen und Schulklassen-Dateien wurden erfolgreich erstellt."




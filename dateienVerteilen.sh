#!/bin/bash

rm -drf gen
mkdir gen

for klassen in $(ls _schulklassen/);
do
	klassenname=$(echo "gen/$klassen" | cut -d "." -f 1)
	mkdir $klassenname
	for schuelername in $(cat "_schulklassen/$klassen")
	do
	   mkdir "$klassenname/$schuelername"
	   cp _templates/* "$klassenname/$schuelername"
	done 
done


#!/bin/bash

# Vérification des paramètres
# S'ils sont absents, on met une valeur par défaut

sourceScript=`pwd`

if [ -z $1 ]
then
        sortie='galerie.html'
else
        sortie=$1
fi
if [ -z $2 ]
then
        source='./'
else
        source=$2
fi

if [ -z $3 ]
then
        taille='200x200>'
else
        taille=$3
fi

# Préparation des fichiers et dossiers
echo '' > $sourceScript/$sortie

if [ ! -e miniatures ]
then
        mkdir miniatures
fi

# En-tête HTML
cat $sourceScript/En-tête >> $sourceScript/$sortie

# Génération des miniatures et de la page
cd $source
for image in `ls *.png *.jpg *.jpeg *.gif 2>/dev/null`
do
	date=`ls -l $image | cut -d ' ' -f 8 && ls -l $image | cut -d ' ' -f 6 && ls -l $image | cut -d ' ' -f 9`
        convert $image -thumbnail $taille "$sourceScript/miniatures/$image"
        echo '<div class="col-xs-4 col-sm-3 col-md-2 text-center"> <a href="'$sourceScript/$source/$image'"><img src="'$sourceScript/miniatures/$image'" alt="" class="img-rounded"></a><p>' $image '</p><p>Dernière modification:' $date '</p></div>' >> $sourceScript/$sortie
done


# Pied de page HTML
cat $sourceScript/Pied-de-page >> $sourceScript/$sortie


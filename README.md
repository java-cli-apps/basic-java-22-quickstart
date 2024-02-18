# Un template d'Application en Ligne de Commande (CLI) utilisant Java 22 et la JEP 458

Le template **basic-java-22-quickstart** permet de démarrer une nouvelle application en commande ligne avec Java sans
utiliser aucun système de build (autre que `make`).

Ce template nécessite d'utiliser Java 22 (ou une version supérieure) car il utilise la JEP 458 qui permet de lancer
plusieurs fichiers sources sans les compiler préalablement.

Le package de l'application comprend les sources ainsi que ses dépendances.

Pour démarrer une nouvelle application en utilisant ce template, vous pouvez suivre les étapes suivantes.

## Changer le nom de l'application

Pour changer le nom de l'application, initialement nommée BasicQuickstart, on peut soit :

- Changer le nom dans le fichier `.envrc` et lancer `direnv allow` si on utilise `direnv`
- Préfixer chaque commande par `APP_NAME=LeNouveauNom` sinon

## Lancer l'application localement

```bash
make test
```

```console
./bin/Application.sh
Bonjour 🇫🇷
```

## Construire le package de l'application

```bash
APP_NAME=MyCmdLine make package
```

```console
mkdir --parents build/MyApp/src build/MyApp/lib build/MyApp/bin
cp --update --recursive src lib bin build/MyApp
cd build/MyApp \
	&& mv src/Application.java src/MyApp.java \
	&& mv bin/Application.sh bin/MyApp.sh
cd build \
	&& zip --quiet --recurse-paths MyApp.zip MyApp
```

Les fichiers `Application.sh` et `Application.java` sont renommés lors de la construction du package, ce qui permet
d'ajouter [plusieurs applications](#lancer-lapplication-installée) dans le `PATH`.

## Installer l'application

```bash
DEST_DIR=/tmp APP_NAME=MyCmdLine make install
```

```console
unzip -q -d /tmp build/MyCmdLine.zip
```

## Lancer l'application installée

```bash
DEST_DIR=/tmp APP_NAME=MyCmdLine make test-install
```

```console
PATH=/tmp/MyCmdLine/bin:/usr/lib/jvm/jdk-22/bin:/home/fopy/.local/bin:... MyCmdLine.sh
Bonjour 🇫🇷
```

Il ne nous reste plus qu'à :

- Implémenter notre métier dans [Application.java](src/Application.java)
- Ajouter les [fichiers](src/fr/Hello.java) qui déclarent les classes utilisées par `Application.java`
- Ajouter les jars de nos dépendances dans le répertoire [lib](lib)

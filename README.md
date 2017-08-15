# [Flujo de trabajo con Git y Gitlab](https://github.com/Mayccoll/Git)

##### Implementación de entornos de desarrollo con control de versiones.


## Introducción

Este documento proporciona un punto de inicio para empezar a trabajar con git y gitlab, abarcando desde los puntos mas básicos hasta algunos un poco mas complejos asegurando cubrir todos los elementos necesarios para un completo flujo de trabajo.

Si bien en git existe una gran variedad de flujos de trabajo en este documento hablaremos del flujo de trabajo bifurcado el cual es diferente a otros flujos de trabajo ya que no consta de un repositorio único del lado del servidor, sino que cada desarrollador tiene dos repositorios Git, uno local y otro en el servidor desde donde envían sus commits a un tercer repositorio gestionado por el director del proyecto.

Algo que hay que tener en cuenta es que el flujo de trabajo con git involucra a todos los integrantes del equipo, por lo que se requiere que estén en buena disposición y dispuestos a cambiar sus paradigmas, así mismo que entiendan en que consiste trabajar con git.

----------------------------------

## Acerca del control de versiones

¿Qué es el control de versiones, y por qué debería ser importarte?

El control de versiones es un sistema que registra los cambios realizados sobre un archivo o conjunto de archivos a lo largo del tiempo, de modo que puedas recuperar versiones específicas más adelante.

Si eres diseñador gráfico o web, y quieres mantener cada versión de una imagen o diseño (algo que sin duda quieres), un sistema de control de versiones (Version Control System o VCS en inglés) es una elección muy sabia. Te permite revertir archivos a un estado anterior, revertir el proyecto entero a un estado anterior, comparar cambios a lo largo del tiempo, ver quién modificó por última vez algo que puede estar causando un problema, quién introdujo un error y cuándo, y mucho más. Usar un VCS también significa generalmente que si fastidias o pierdes archivos, puedes recuperar los fácilmente. Además, obtienes todos estos beneficios a un coste muy bajo. (fuente: http://git-scm.com/book/es/Empezando-Acerca-del-control-de-versiones)

----------------------------------

## GIT

Git es un software de control de versiones diseñado por Linus Torvalds, pensando en la eficiencia y la confiabilidad del mantenimiento de versiones de aplicaciones cuando estas tienen un gran número de archivos de código fuente.

Git se ha convertido desde entonces en un sistema de control de versiones con funcionalidad plena. 3 Hay algunos proyectos de mucha relevancia que ya usan Git, en particular, el grupo de programación del núcleo Linux. (fuente: wikipedia)

----------------------------------

## GitLab

Es un aplicación para administrar proyectos con el control de versiones Git, basada en Ruby on Rails es software libre. Tiene un gran parecido tanto visual como funcionalmente a lo que es GitHub. En el podemos observar algunas de sus funciones como manejar distintos proyectos, manejar usuarios, ver commits, ver archivos, ver ramas, ver gráficos, asignar tareas, ver merge, editar archivos, Wiki, entre otras.

----------------------------------

## Requisitos programador

- Disposición al cambio

- Manejo de GIT

- Manejo de github o gitlab.

- Conocimiento de Markdown (opcional).

----------------------------------

## Requerimientos de software

- cliente ssh

- git

- Gitlab (Github)

- Opcionales

  - Meld

  - Git GUI

----------------------------------

## Pre-Configuración

- Install git (Ubuntu)

```bash
  $
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt update
  sudo apt -y install git
```

- Install git (Centos)

```bash
  # Centos from source
  $
  sudo yum groupinstall "Development Tools"
  sudo yum install zlib-devel perl-ExtUtils-MakeMaker asciidoc xmlto openssl-devel
  wget -O git.zip https://github.com/git/git/archive/master.zip
  unzip git.zip
  cd git-master
  make configure
  ./configure --prefix=/usr/local
  make all doc
  sudo make install install-doc install-html
```

- Instalar cliente ssh

```bash
  $
  sudo apt -y install openssh-client
```

- Configurar git

```bash
  $
  git config --global user.name "USERNAME"
  git config --global user.email "EMAIL@EMAIL.com"
```
- Crear llave ssh

```bash
  $
  ssh-keygen -t rsa -b 4096
```

- Crear y Editar archivo config (Para gitlab self hosted)

>>> ~/.ssh/config

```bash
Host gitlab.com
  HostName 192.168.10.10
  User git
  Port 22
  IdentityFile ~/.ssh/id_rsa
  Compression yes
  CompressionLevel 9
  IdentitiesOnly yes
```

- Ingresar a gitlab (Github)

- Inscribir llave ssh en gitlab

----------------------------------

### Extras

- **Install Diff So Fancy**

https://github.com/stevemao/diff-so-fancy

```bash
  npm i -g diff-so-fancy
```

- **Configuraciones Opcionales**

```bash
  $
  git config --global color.ui true
  git config --global log.decorate true
  git config --global log.abbrevCommit false
  git config --global core.autocrlf input
  git config --global core.safecrlf true
  git config --global help.autocorrect 3
  # only pushes the current branch to the corresponding remote branch
  git config --global push.default simple
  # Config Editor
  git config --global core.editor atom
  # Ignore file mode (chmod) changes
  git config core.fileMode false
```

- **Editar /home/USER/.gitconfig**

```
  $ git config --global --edit
```

```
[alias]
    co     = checkout
    ck     = checkout
    br     = branch
    ci     = commit
    st     = status
    s      = status
    c      = commit -m
    i      = !git ls-files -v | grep "^[[:lower:]]"
    ll     = !git --no-pager log -50 --graph --date-order -C -M --pretty=format:\"%C(yellow)%h%C(reset) - %C(green)%ad%C(reset) - %C(blue)%an%C(reset) %C(bold red)-%C(reset) %C(white)%s%C(reset) %C(bold red)%d%C(reset) \" --abbrev-commit --date=short
    up-sub = "!f() { cd $1 && git checkout master && git pull && git submodule update --init --recursive; }; f"
    ff     = "!git diff --color $@ | diff-so-fancy"

[help]
    autocorrect = 3

[log]
    abbrevCommit = false
    decorate = true

[push]
    default = simple

[color]
    ui = true

[core]
    autocrlf = input
    safecrlf = true
    editor = atom
```


## Flujo de trabajo Bifurcado (Fork-Branch)

El workflow bifurcado es diferente de los otros workflows. En vez de usar un repositorio de un único lado del servidor para actuar código base “central”, le da a todos los desarrolladores un repositorio del lado del servidor. Esto significa que cada colaborador no tiene solo uno, sino dos repositorios Git: uno privado y local, y uno público en el servidor.
[Fuente](https://www.atlassian.com/es/git/workflows#!workflow-forking)

Los pasos en este workflow aunque siguen una secuencia lógica no quiere decir que se deban ejecutar todos cada vez que se empieza a trabajar y algunos son opcionales dependiendo si son necesarios. Lo importante es saber que hace cada comando y se deja a criterio del programador si es necesario ejecutarlo o no.

#### - Hacer un FORK del repositorio upstream. (UNA VEZ)

 Este se hace sobre la plataforma gitlab (github) y se hace un fork del repositorio que se denomina **upstream** (repositorio principal donde todos los programadores aportaran sus cambios).

#### - Clonar el repositorio en la maquina donde se va a trabajar.
  Al repositorio que esta en gitlab (github) se le denomina **remote** y al clone que esta en nuestra maquina de trabajo se le denomina **local**

  ```bash
    $ git clone git@gitlab.com:/usuario/proyecto
  ```

#### - Agregar vinculo a upstream en el repositorio local. **(UNA VEZ)**

 Resalto USUARIO en mayúscula porque normalmente eso es lo único que cambia, apuntando al usuario que hospeda el repositorio principal (upstream)
 Este repositorio es aquel que en un principio le hicimos un fork

  ```bash
    $ git remote add upstream git@gitlab.com:/USUARIO/proyecto
  ```

#### - **Actualizar** la rama master con repositorio upstream.

  Este paso es **importante** si hemos clonado previamente el repositorio y después de un tiempo vamos a volver a trabajar

  ```bash
    $ git fetch upstream
    $ git merge upstream/master
  ```

#### - Crear una **BRANCH** con titulo detallado sobre lo que vas a trabajar

  ```bash
    $ git branch mejora_345
  ```

#### - Cambiar rama.

  ```bash
    $ git checkout mejora_345
  ```

#### - Trabajar

#### - Agregar cambios y hacer **commit**.

  ```bash
    $ git add [ARCHIVO]
    $ git commit -m "COMENTARIO DETALLADO"
  ```

#### - **Actualizar** repositorio con upstream y verificar conflictos que no tenga conflictos (Importante).

  ```bash
    $ git fetch upstream
    $ git merge upstream/master
    # la rama puede ser master o cualquier otra que tengamos designada para hacer las contribuciones
  ```

#### - Hacer push

  Este paso tiene 2 fines.

  Uno asegurar nuestros cambios subiendo los al repositorio remoto (gitlab o github)

  Dos disponer de la rama en gitlab (github) para hacer un merge request.

  ```bash
    $ git push origin [mejora_345]
  ```

#### - Solicitar un Merge Request

  Este se hace sobre la plataforma gitlab (github) y con el le estamos diciendo al usuario que maneja el repositorio principal (upstream) que nuestro código funciona y esta listo para ser integrado con el proyecto.

#### - Actualizar la rama master.

  ```bash
    $ git checkout master
    $ git merge [mejora_345]
  ```

#### - Hacer push de nuestra rama master.

  Finalmente con esto aseguramos que nuestro repositorio en gitlab se encuentra al dia con todos nuestros cambios y podemos volver a el cuando queramos simplemente clonado el repositorio.

  ```bash
    $ git push origin master
  ```

#### Resumen:

- Fork
- Clone
- Update master
- Crear Rama
- Cambiar a Rama
- Commit en Rama
- Update Rama
- Push Rama
- Solicitar Merge Request
- Cambiar a master
- Update master
- Push master

-----------------------------------

## Como hacer un Commit

* Hablar sobre las funcionalidades del nuevo código, no sobre ti mismo. Muchas veces caemos en el error de hablar sobre lo que hicimos, obviando lo que hace actualmente el código modificado. Hay que fijar el objetivo de ese commit centrándonos en la historia de usuario que estamos realizando.

* Si queremos ampliar (dentro de un límite) podemos hablar de la motivación del cambio y contrastar la implementación con el comportamiento anterior.

* No hablar en pasado. Muchos ortodoxos opinan que lo mejor es usar la forma imperativa del verbo que usemos para indicar que hace este commit.

* Evitar referencias temporales en el mensaje de commit, la revisión ya incluye la fecha de modificación.

* Aportar meta información en los commmit. Si usamos herramientas integradas como Stash y Jira, podemos adjuntar los identificadores de las tareas que hayamos realizado en el commit para enlazar el código modificado con la propia historia. De esta forma podemos revisar el estado y ampliar la información de cada tarea de JIRA con el código fuente.

* Utilizar una primera frase de no más de 50 caracteres que resuma el contenido del commit. Muy útil si pensamos cuando nos movemos con herramientas como Sourcetree (en la vista general) o la terminal, donde sólo vemos la primera línea del commit.

---------------------------------------

## Comandos Utiles

#### - **Crea un repositorio.**

```bash
  $ git init
```

#### - **Show individual files in untracked directories.**

```bash
  $ git status -u
```

#### - **Crea un copia en local (clone).**

```bash
  $ git clone [URL_GIT_REPO]  
  # ejem:
  #      git clone git@github.com:sbadia/vagrant-gitlab.git

  # Hacer una copia de un repositorio local
  $ git clone /path/to/repository

  # Hacer una copia en un servidor remoto
  $ git clone username@host:/path/to/repository
```

#### - **Agregar archivos al stage area (archivos listo para hacer commit).**

```bash
  $ git add [filename]
  # o
  $ git add .
```

#### - **Crear un commit**

```bash
  $ git commit -m "Commit message"
```

#### - **Añadir remoto**

```bash
  $ git remote add [UPSTREAM] [URL_GIT_REPO]
  # ejem:
  #      git remote add upstream git@github.com:sbadia/vagrant-gitlab.git
```

#### - **Enviar cambios a un repositorio remoto**

```bash
  $ git push [REMOTE] [BRANCH]
  # ejem:
  #      git push origin master
```

#### - **Crear una rama**

```bash
  $ git branch [BRANCH_NAME]
    # ejem:
    #      git branch hot_fix_43
```

#### - **Cambiar a una rama**

```bash
  $ git checkout [BRANCH_NAME]
    # ejem:
    #      git checkout hot_fix_43
```

#### - **Volver a la rama principal**

```bash
  $ git checkout master
```

#### - **Crear una rama y cambiarse a ella**

```bash
  $ git checkout -b [BRANCH_NAME]
  # ejem:
  #      git checkout -b hot_fix_43
```

#### - **Borrar una rama**

```bash
  $ git branch -d [BRANCH_NAME]
  # ejem:
  #      git branch -d hot_fix_43
```

#### - **Borrar una rama con commits adelante de master**

  ```bash
    # WARNING podremos perder commits
  $ git branch -D [BRANCH_NAME]
    # ejem:
    #      git branch -D hot_fix_43
  ```

#### - **Subir una rama al repositorio remoto**

```bash
  $ git push origin [BRANCH_NAME]
  # ejem:
  #      git push origin hot_fix_43
```

#### - **Recibir cambios en repositorios remotos**

```bash
  $ git fetch [REMOTE_NAME]
```

#### - **Fusionar otra rama con la rama activa**

```bash
  $ git merge [BRANCH_NAME]
```

#### - **Actualizar repositorio local con los últimos commits en el remoto**

```bash
  $ git pull
```

#### - **Revisar cambios entre ramas**

```bash
  $ git diff [source_branch] [target_branch]
```

#### - **Git logs**

```bash
  # Ver commits id
  $ git log

  # Ver logs con graficos y colores
  $ git log -10 --graph --date-order -C -M --pretty=format:"%C(yellow)%h%C(reset) - %C(bold green)%ad%C(reset) - %C(dim yellow)%an%C(reset) %C(bold red)>%C(reset) %C(white)%s%C(reset) %C(bold red)%d%C(reset) " --abbrev-commit --date=short
```

#### - **Remote**

```bash
  # Ver remotos.
  $ git remote

  # Push a todas las ramas
  $ git push --all origin

  # Ver remoto con url asociada.
  $ git remote -v

  # Añadir remoto
  $ git remote add origin git@192.168.77.24:adminturri/tti.git

  # Remover remoto
  $ git remote rm origin

  # Recibiendo de remotos
  $ git fetch [REMOTE_NAME]

  # Borrar rama en repositorio remoto
  $ git push origin :[REMOTE_NAME]

  # Disable PUSH
  $ git remote set-url --push origin NO-PUSH
```
#### - **Branch**

```bash
  # Ver todas las ramas
  $ git branch -a

  # Crear  BRANCH desde unstaged/uncommited  en master
  $ git checkout -b [NEW_BRANCH_NAME]

  # Remove local branch
  $ git branch -d [THE_LOCAL_BRANCH]

  # Borrar rama en repositorio remoto
  $ git push origin :[REMOTE_NAME]
```

#### - **Abortar Merge**

```bash
  $ git merge --abort
```
#### - **Descartar cambios en un archivo**

```bash
  $ git checkout [FILE_NAME]
```

#### - **Remove untracked files (WARNING)**

```bash
  # (WARNING)
  $ git clean -f -d
```

#### - **Reverter cualquier cambio**

```bash
  $ git checkout -f
  # o
  $ git reset --hard
```

#### - **Deshacer todos los cambios y volver a la ultima version del repositorio remoto**

```bash
  $ git fetch origin
  $ git reset --hard origin/master
```

#### - **Create tag**

```bash
  $ git tag 1.0.0 1b2e1d63ff
```

#### - **View files in commit**

```bash
  $ git diff-tree --no-commit-id --name-only -r bd61ad98
```

#### - **View remote commits**

```bash
  $ git log origin/master
```

#### - **Removes staged and working directory changes**

```bash
  $ git reset --hard
```

#### - **Git gui**

```bash
  $ gitk
```

#### - **Change commit author and email**

```bash
git filter-branch --commit-filter '
        if [ "$GIT_COMMITTER_NAME" = "<OLD_NAME>" ];
        then
                GIT_COMMITTER_NAME="<NEW_NAME>";
                GIT_AUTHOR_NAME="<NEW_NAME>";
                GIT_COMMITTER_EMAIL="<NEW_EMAIL>";
                GIT_AUTHOR_EMAIL="<NEW_EMAIL>";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi' HEAD
```

#### - **List all files in repository**

```sh
    git show --pretty="format:" --name-only

    git log --pretty=format: --name-status | cut -f2- | sort -u

    git ls-tree -r master --name-only
```

#### - **List all commits for a specific file**

```sh
    git log --follow --oneline text.txt
```

#### - **List all commits for a specific file**

```sh
    git log --follow --pretty=format:'%h - %ai' --abbrev-commit text.txt
```

#### - **List all commits for a specific file with Date format**

```sh
    git log --follow --date=iso --pretty=format:'%ad%x08%x08%x08%x08%x08%x08%x08%x08%x08%x08%x08%x08%x08%x08%x08 - %h - %s' --abbrev-commit text.txt
```

#### - **Get all extensions and their respective file count in a repository**

```sh
    git show --pretty="format:" --name-only | grep -E ".*\.[a-zA-Z0-9]*$" | sed -e 's/.*\(\.[a-zA-Z0-9]*\)$/\1/' | sort | uniq -c | sort -n
```

#### - **Delete merged branches**

```sh
  git branch --merged | grep -v \* | grep -v master | xargs git branch -d
```

#### - **Reset and sync local respository with remote branch**

```bash
  $ git fetch origin
  $ git reset --hard origin/master
  # (WARNING)
  $ git clean -f -d
```

-----------------------------------

## Diff Tools

- View last changes in file

```bash
  $
  git difftool HEAD^ <file>
```

- View single file

```bash
    $ git difftool test:README.md remotes/origin/master:README.md
```

- View local master and remote

```bash
    $ git difftool master remotes/upstream/next
```

- Revisar cambios entre ramas

```bash
    $ git diff <source_branch> <target_branch>
```

- Ver archivos de un commit

```bash
    $ git diff-tree --no-commit-id --name-only -r bd61ad98
```

## SubModulos

- Adding a submodule

```bash
$ git submodule add git://github.com/jquery/jquery.git

$ git submodule add git://github.com/tpyo/amazon-s3-php-class.git s3-class

$ git add .

$ git commit -m "Added two new submodules."
```

- Cloning a Repo with Submodules

```bash
$ git clone git@github.com:mexitek/fake-repo-whatevs.git

$ cd fake-repo-whatevs/

$ git submodule init

$ git submodule update

```

- Update Submodule

```bash
  $
  git config --global alias.up-sub '!f() { cd $1 && git checkout master && git pull && git submodule update --init --recursive; }; f'
  # Use:
  git up-sub SUB_MODULE_FOLDER
```

- Updating Submodules For Your Parent Repo

```bash
  $
  cd PATH_TO_SUBMODULE/
  git pull origin master # <-- don't forget master!!
  cd PATH_TO_PARENT_REPO/
  git commit -am "Upgrading our Submodules"
  git push origin
  ```

  - Pulling Submodule Updates From Parent Repo

  ```bash
  $ git pull origin

  $ git submodule update
  ```

  ## Syncing a fork

  Before you can sync, you need to add a remote that points to the upstream repository. You may have done this when you originally forked.

  **Tip: Syncing your fork only updates your local copy of the repository; it does not update your repository on GitLab.**      **

  There are two steps required to sync your repository with the upstream: first you must fetch from the remote, then you must merge the desired branch into your local branch.
  ```bash
  $ git remote -v
  # List the current remotes
  # origin  https://github.com/user/repo.git (fetch)
  # origin  https://github.com/user/repo.git (push)

  $ git remote add upstream https://github.com/otheruser/repo.git
  # Set a new remote

  $ git remote -v
  # Verify new remote
  # origin    https://github.com/user/repo.git (fetch)
  # origin    https://github.com/user/repo.git (push)
  # upstream  https://github.com/otheruser/repo.git (fetch)
  # upstream  https://github.com/otheruser/repo.git (push)
  ```
  ### Fetching

  Fetching from the remote repository will bring in its branches and their respective commits. These are stored in your local repository under special branches.
  ```bash
  $ git fetch upstream
  # Grab the upstream remote's branches
                               # remote: Counting objects: 75, done.
                               # remote: Compressing objects: 100% (53/53), done.
                               # remote: Total 62 (delta 27), reused 44 (delta 9)
                               # Unpacking objects: 100% (62/62), done.
                               # From https://github.com/otheruser/repo
                               #  * [new branch]      master     -> upstream/master
```

We now have the upstream's master branch stored in a local branch, ```upstream/master```
```bash
git branch -va
# List all local and remote-tracking branches
# * master                  a422352 My local commit
#   remotes/origin/HEAD     -> origin/master
#   remotes/origin/master   a422352 My local commit
#   remotes/upstream/master 5fdff0f Some upstream commit
```

### Merging

Now that we have fetched the upstream repository, we want to merge its changes into our local branch. This will bring that branch into sync with the upstream, without losing our local changes.

```bash
git checkout master
# Check out our local master branch
# Switched to branch 'master'

git merge upstream/master
# Merge upstream's master into our own
# Updating a422352..5fdff0f
# Fast-forward
#  README                    |    9 -------
#  README.md                 |    7 ++++++
#  2 files changed, 7 insertions(+), 9 deletions(-)
#  delete mode 100644 README
#  create mode 100644 README.md
```

If your local branch didn't have any unique commits, git will instead perform a "fast-forward":
```bash
git merge upstream/master
# Updating 34e91da..16c56ad
# Fast-forward
#  README.md                 |    5 +++--
#  1 file changed, 3 insertions(+), 2 deletions(-)
```

## Funcionales

- Git Extras

```bash
https://github.com/visionmedia/git-extras
```

- Git - La Guía Sencilla

```bash
http://rogerdudler.github.io/git-guide/index.es.html
```

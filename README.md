Git y Gitlab Fujo de trabajo
=====
#### Implementacion de entornos de desarrollo con control de versiones.

- - -

Lo primero que hay que tener en cuenta es que el flujo de trabajo con git  involucra a todos los integrantes del equipo, por lo que se requiere que esten en buena disposición y dispuestos a cambiar sus paradigmas, así mismo que entiendan en que consiste trabajar con git.



## Acerca del control de versiones

¿Qué es el control de versiones, y por qué debería ser importarte?

El control de versiones es un sistema que registra los cambios realizados sobre un archivo o conjunto de archivos a lo largo del tiempo, de modo que puedas recuperar versiones específicas más adelante.

Si eres diseñador gráfico o web, y quieres mantener cada versión de una imagen o diseño (algo que sin duda quieres), un sistema de control de versiones (Version Control System o VCS en inglés) es una elección muy sabia. Te permite revertir archivos a un estado anterior, revertir el proyecto entero a un estado anterior, comparar cambios a lo largo del tiempo, ver quién modificó por última vez algo que puede estar causando un problema, quién introdujo un error y cuándo, y mucho más. Usar un VCS también significa generalmente que si fastidias o pierdes archivos, puedes recuperarlos fácilmente. Además, obtienes todos estos beneficios a un coste muy bajo.
(fuente: http://git-scm.com/book/es/Empezando-Acerca-del-control-de-versiones)


## GIT

Git es un software de control de versiones diseñado por Linus Torvalds, pensando en la eficiencia y la confiabilidad del mantenimiento de versiones de aplicaciones cuando estas tienen un gran número de archivos de código fuente.

Git se ha convertido desde entonces en un sistema de control de versiones con funcionalidad plena. 3 Hay algunos proyectos de mucha relevancia que ya usan Git, en particular, el grupo de programación del núcleo Linux.
(fuente: wikipedia)



## GitLab

Es un aplicación para administrar proyectos con el control de versiones Git, basada en Ruby on Rails es software libre. Tiene un gran parecido tanto visual como funcionalmente a lo que es GitHub.
En el podemos observar algunas de sus fucniones como manejar distintos proyectos, manejar usuarios, ver commits, ver archivos, ver ramas, ver gráficos, asignar tareas, ver meger, editar archivos, Wiki, entre otras.



## Requisitos programador.

- Disposicion al cambio
- Manejo de GIT
- Manejo de github o gitlab.
- Conocimiento de Markdown.



## Requerimientos de software

- cliente ssh
- git
- Gitlab
- (opcionales)
 - Meld
 - Git GUI



## Pre-Configuracion

- Instalar git

- Instalar cliente ssh

- Configurar git 

```bash
    $ git config --global user.name "USERNAME"
    $ git config --global user.email "EMAIL@EMAIL.com"
    $ git config --global color.ui true
```

- Crear llave ssh

```bash
    $ ssh-keygen
```

- Crear y Editar archivo config
- Ingresar a gitlab
- Inscribir llave ssh en gitlab


## Flujo de trabajo FORK

- Hacer un FORK del repositorio a tu cuenta. **(UNA VEZ)**

- Clonar el repositorio a tu maquina.**(UNA VEZ)**

```bash
	$ git clone git@REPO.git
```

- Agregar upstream remoto. **(UNA VEZ)**

```bash
	$ git remote add upstream git@REPO.git
    
    # Esto ahora te permitirá que hacer un pull de cambios del origen localmente y combinarlos, así:
    $ git fetch upstream
	
	$ git merge upstream/master
```

- Crear una BRANCH con titulo detallado sobre lo que vas a trabajar 

```bash
	$ git branch mejora_345
```

- Cambiar rama.

```bash
	$ git checkout mejora_345
```

- Trabajar

- Agregar los cambios

```bash
    $ git add <FILE>
    
    # o
    
    $ git add .
```

- Haz COMMIT

```bash
    $ git commit --am "COMENTARIO DETALLADO"
```

- Haz un PUSH

```bash
	$ git push origin mejora_345
```

- Crea un PULL REQUEST





## Flujo de trabajo branch

- Clonar el repositorio.

```bash
	$ git clone REPO
```

- Crear un branch

```bash
	$ git branch NUEVA
```

- Trabajar

- Agregar los cambios

```bash
	$ git add .
```
- Hacer commit

```bash
	$ git commit -m “COMENTARIO DETALLADO”
```

- Hacer un push de la branch

```bash
	$ git push -u origin BRANCH
```



## Comandos Basicos

- Crea un repositorio

```bash
	$ git init
```

- Crea un copia en gitlab (clone)

```bash
    $ git clone git@github.com:sbadia/vagrant-gitlab.git
```

- Agregar archivos al stage area (archivos listo para hacer commit)

```bash
	$ git add <filename>
	
    # o
    
    $ git add .
```

- Crear un commit

```bash
	$ git commit -m "Commit message"
```

- Añadir remoto

```bash
	$ git remote add origin <server>
```

- Enviar cambios a un repositorio remoto

```bash
	$ git push origin master
```

- Crear una rama

```bash
	$ git branch <branch_name>
```

- Cambiar a una rama

```bash
	$ git checkout <branch_name>
```

- Volver a la rama principal

```bash
	$ git checkout master
```

- Crear una rama y cambiarse a ella

```bash
	$ git checkout -b feature_x
```

- Borrar una rama

```bash
	$ git branch -d <branch_name>
```

- Subir una rama al repositorio

```bash
	$ git push origin <branch_name>
```

- Recibir repositorios remotos

```bash
	$ git fetch <remote_name>
```

- Fusionar otra rama con la rama activa

```bash
	$ git merge <branch>
```

- Actualizar repositorio local con los ultimos commits en el remoto

```bash
	$ git pull
```

- Revisar cambios entre ramas

```bash
	$ git diff <source_branch> <target_branch>
```

## Comandos Extra

- Push a todas las ramas

```bash
	$ git push --all origin
```

- Crea un copia (clone)

```bash
	# Hacer una copia de un repositorio local
	$ git clone /path/to/repository

    # Hacer una copia en un servidor remoto
    $ git clone username@host:/path/to/repository
```

- Ver remotos.

```bash
	$ git remote
```

- Ver remoto con url asociada.

```bash
	$ git remote -v
```

- Añadir remoto

```bash
	$ git remote add origin git@192.168.77.24:adminturri/tti.git
```

- Remover remoto

```bash
	$ git remote rm origin
```

- Recibiendo de remotos

```bash
	$ git fetch <emote-name>
```

- Borrar rama en repositorio remoto

```bash
	$ git push origin :<branch_name>
```

- Crear  BRANCH desde unstaged/uncommited  en master

```bash
	$ git checkout -b new_branch_name
```

- Remove local branch

```bash
	$ git branch -d the_local_branch
```

- Remove remote branch

```bash
	$ git push origin :the_remote_branch
```

- Abortar Merge

```bash
	$ git merge --abort
```

- Reverter cualquier cambio

```bash
	$ git checkout -f
```

- Crear una etiqueta

```bash
	$ git tag 1.0.0 1b2e1d63ff
```

- Ver commits id

```bash
	$ git log
```

- Descartar cambios en un archivo

```bash
	$ git checkout -- <filename>
```

- Deshacer todos los cambios y volver a la ultima version del repositorio remoto

```bash
	$ git fetch origin
    $ git reset --hard origin/master
```

- Ver archivos de un commit

```bash
	$ git diff-tree --no-commit-id --name-only -r bd61ad98
```

- Git interfaz grafica

```bash
	$ gitk
```


### Diff Tools

- View single file 

```bash
	$ git difftool test:README.md remotes/origin/master:README.md
```

- View local master and remote

```bash
	$ git difftool master remotes/upstream/next
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

-Updating Submodules For Your Parent Repo

```bash 
	$ cd PATH_TO_SUBMODULE/
	
	$ git pull origin master # <-- don't forget master!!
	
	$ cd PATH_TO_PARENT_REPO/
	
	$ git commit -am "Upgrading our Submodules"
	
	$ git push origin

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
#### Fetching

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

#### Merging

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

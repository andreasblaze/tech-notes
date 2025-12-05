---
sidebar_position: 1
---
# CMD

## git config
```bash
git config --global user.name "Your Name"
```
```bash
git config --global user.email "your.email@example.com"
```

## Переименование коммитов
### amend
Если вам нужно изменить только последнее сообщение коммита:
```bash
git commit --amend
```
Save and Close the Editor
Push the Amended Commit:
```bash
git push --force-with-lease
```

### rebase
```bash
git rebase -i HEAD~5
```
Потом надо будет поменять `pick` на `reword` для каждого коммита.

После редактирования **Git** завершит `rebase`. Если возникнут конфликты, **Git** остановится и позволит вам разрешить их. После разрешения конфликтов (если таковые имеются) выполните:
```bash
git rebase --continue
```
После надо принудительно отправить изменения в удаленный репозиторий:
```bash
git push --force-with-lease
```
## Undo a commit
```bash
git reset HEAD~
```

## Git Squash
Это прием, который помогает взять серию коммитов и уплотнить ее. 

Например, предположим: у вас есть серия из N коммитов и вы можете путем сжатия преобразовать ее в один-единственный коммит. Сжатие через `git squash` в основном применяется, чтобы превратить большое число малозначимых коммитов в небольшое число значимых. Так становится легче отслеживать историю Git.

Делается с помощью либо UI, либо `git rebase`

https://medium.com/nuances-of-programming/как-сжимать-коммиты-в-git-с-помощью-git-squash-8a84b9f62734

## git remote
```bash
git remote -v
# output:
# origin  https://github.com/andreasblaze/tech-notes.git (fetch)
# origin  https://github.com/andreasblaze/tech-notes.git (push)
```
- **origin**: Это имя удаленного репозитория. По соглашению origin — это имя по умолчанию, которое присваивается удаленному репозиторию при клонировании репозитория или добавлении нового удаленного репозитория.
- https://github.com/andreasblaze/tech-notes.git: Это URL-адрес удаленного репозитория. Это место, где ваш репозиторий размещен на GitHub.
- (**fetch**): Это URL-адрес, используемый для загрузки изменений из удаленного репозитория в ваш локальный репозиторий. Когда вы запускаете такие команды, как `git fetch` или `git pull`, Git будет использовать этот URL-адрес для получения обновлений.
- (**push**): Это URL-адрес, используемый для отправки изменений из локального репозитория в удаленный репозиторий. Когда вы запускаете такие команды, как `git push`, Git будет использовать этот URL-адрес для отправки ваших изменений в удаленный репозиторий.

### Common Names for Remotes
- **origin**: по умолчанию, когда вы клонируете репозиторий, Git называет удаленный репозиторий `origin`. Это основной репозиторий, из которого вы клонировали, и это наиболее часто используемое удаленное имя.
- **upstream**: если вы работаете с ответвлением репозитория, `upstream` часто используется для обозначения исходного репозитория, из которого был создан ваш форк. Это позволяет вам получать обновления из исходного репозитория, чтобы поддерживать ваш форк в актуальном состоянии.

### Add a New Remote
```bash
git remote add origin https://github.com/user/repo.git
```
> Здесь origin — это имя удаленного сервера, а URL — это местоположение репозитория.

### Remove a Remote
```bash
git remote remove origin
```
> Эта команда удаляет удаленный репозиторий.

### Rename a Remote
```bash
git remote rename origin upstream
```
> Эта команда переименовывает существующий `origin` в `upstream`.

### Show Information About a Remote
```bash
git remote show origin
# output:
# * remote origin
#   Fetch URL: https://github.com/andreasblaze/tech-notes.git
#   Push  URL: https://github.com/andreasblaze/tech-notes.git
#   HEAD branch: main
#   Remote branches:
#     gh-pages new (next fetch will store in remotes/origin)
#     main     tracked
#   Local branch configured for 'git pull':
#     main merges with remote main
#   Local ref configured for 'git push':
#     main pushes to main (up to date)
```
> Эта команда показывает подробную информацию о конкретном удаленном репозитории.

### git clone-remote issue
Если ранее репозиторий был склонирован путем `https`, а сейчас требует `ssh`:
```bash
git remote set-url origin <repo_url>
```
## git branch
```bash

```

## git add
```bash

```

## git commit
```bash

```

## git push 
```bash

```

## git pull
```bash

```

## git fetch
```bash

```

## git show
```bash

```

## git blame
```bash

```

## git revert
This creates a new commit that undoes the changes from the problematic commit(s), preserving your history:
```bash
git revert <commit-hash>
```
```bash
git push origin master
```

## git diff
```bash

```

## git log
Use the Git log to find the commit hash of the last stable state:
```bash
git log --oneline
```

## Незакоммиченные изменения
Либо коммитить
```bash
git add
```
+
```bash
git commit
```
```bash
git checkout
```
либо:
### git stash
Переключить ветки без фиксации изменений (коммита):
```bash
git stash
```
```bash
git checkout master
```
Позже можно вернуть изменения с помощью:
```bash
git stash pop
```
Если мы хотим отказаться от изменений и вернуть файлам исходное состояние:
```bash
git restore <path-to-file-1> <path-to-file-2>
```
```bash
git checkout master
```

## git status
```bash

```

## git tag
To make rolling back easier in the future, consider tagging stable commits:
```bash
git tag -a stable -m "Stable version of Alertmanager config"
```
```bash
git push origin stable
```
```bash
git reset --hard stable
```
```bash
git push origin master --force
```

## git checkout
If you just need to deploy the stable commit temporarily without making changes to master:
```bash
git checkout <commit-hash>
```
```bash
git checkout master
```

## git reset
Remove the last commit locally:
```bash
git reset --hard HEAD~1
```
Force push the changes:
```bash
git push origin SRE-33572-update-to-use-vault-secrets --force
```

Use the Git log to find the commit hash of the last stable state:
```bash
git log --oneline
```
This will completely reset your branch to the specified commit and discard any changes made after it:
```bash
git reset --hard <commit-hash>
```
```bash
git push origin master --force
```

## Undo a commit & redo
```bash
# Source - https://stackoverflow.com/a
# Posted by Esko Luontola, modified by community. See post 'Timeline' for change history
# Retrieved 2025-12-05, License - CC BY-SA 4.0

$ git commit -m "Something terribly misguided" # (0: Your Accident)
$ git reset HEAD~                              # (1)
# === If you just want to undo the commit, stop here! ===
[ edit files as necessary ]                    # (2)
$ git add .                                    # (3)
$ git commit -c ORIG_HEAD                      # (4)
```
1. `git reset` is the command responsible for the undo. It will undo your last commit while leaving your working tree (the state of your files on disk) untouched. You'll need to add them again before you can commit them again.
2. Make corrections to working tree files.
3. git add anything that you want to include in your new commit.
4. Commit the changes, reusing the old commit message. reset copied the old head to .git/ORIG_HEAD; commit with -c ORIG_HEAD will open an editor, which initially contains the log message from the old commit and allows you to edit it. If you do not need to edit the message, you could use the -C option.

Alternatively, to edit the previous commit (or just its commit message), commit `--amend` will add changes within the current index to the previous commit.

To remove (not revert) a commit that has been pushed to the server, rewriting history with git push origin main `--force[-with-lease]` is necessary. It's almost always a bad idea to use `--force`; prefer `--force-with-lease` instead, and as noted in the git manual:
> You should understand the implications of rewriting history if you amend a commit that has already been published.
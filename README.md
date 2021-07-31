# git-usefull

# Развернуть проект из удаленного репозитория локально
- git init
- git remote add origin PATH/TO/REPO
- git fetch
- git checkout -t origin/main - для GITHUB, master - для Bitbucket

# удалить индексируемую папку из репозитория

- git filter-branch --tree-filter "rm -rf PATH" HEAD
- git push origin master --force

# Изменить владельца папки, пример
- sudo chown -R goohuunter:www-data lc-cert


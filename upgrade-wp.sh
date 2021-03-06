#!/bin/sh
# @(#) This script is for upgrading wordpress.

echo "upgrade start!"
# log in to git
source ./ssh-git.sh
# move to wordpress-project-folder
# "work" is alias to working directory
work && cd wordpress_gae/wordpress
# replace the target files
cp -R wp-admin ~/.Trash/ && rm -rf wp-admin/ && cp -R ~/Downloads/wordpress/wp-admin .
# remove default theme
cp -R wp-content/themes/twentysixteen ~/.Trash/ && rm -rf wp-content/themes/twentysixteen/ && cp -R ~/Downloads/wordpress/wp-content/themes/twentysixteen wp-content/themes/
# replace the target files
cp -R wp-includes ~/.Trash/ && rm -rf wp-includes/ && cp -R ~/Downloads/wordpress/wp-includes .
cp index.php ~/.Trash/ && rm -f index.php && cp ~/Downloads/wordpress/index.php .
cp license.txt ~/.Trash/ && rm -f license.txt && cp ~/Downloads/wordpress/license.txt .
cp readme.html ~/.Trash/ && rm -f readme.html && cp ~/Downloads/wordpress/readme.html .
cp xmlrpc.php ~/.Trash/ && rm -f xmlrpc.php && cp ~/Downloads/wordpress/xmlrpc.php .
# replace the target files starting with wp-*, except wp-config-*.php
cp wp-activate.php ~/.Trash/ && rm -f wp-activate.php && cp ~/Downloads/wordpress/wp-activate.php .
cp wp-blog-header.php ~/.Trash/ && rm -f wp-blog-header.php && cp ~/Downloads/wordpress/wp-blog-header.php .
cp wp-cron.php ~/.Trash/ && rm -f wp-cron.php && cp ~/Downloads/wordpress/wp-cron.php .
cp wp-links-opml.php ~/.Trash/ && rm -f wp-links-opml.php && cp ~/Downloads/wordpress/wp-links-opml.php .
cp wp-load.php ~/.Trash/ && rm -f wp-load.php && cp ~/Downloads/wordpress/wp-load.php .
cp wp-login.php ~/.Trash/ && rm -f wp-login.php && cp ~/Downloads/wordpress/wp-login.php .
cp wp-mail.php ~/.Trash/ && rm -f wp-mail.php && cp ~/Downloads/wordpress/wp-mail.php .
cp wp-settings.php ~/.Trash/ && rm -f wp-settings.php && cp ~/Downloads/wordpress/wp-settings.php .
cp wp-signup.php ~/.Trash/ && rm -f wp-signup.php && cp ~/Downloads/wordpress/wp-signup.php .
cp wp-trackback.php ~/.Trash/ && rm -f wp-wp-trackback.php && cp ~/Downloads/wordpress/wp-trackback.php .
echo "
"
# show git modification
git status
echo "
"
echo -n "Enter \"OK\", if the result is fine, otherwise something else then this script will stop :"
read RESULT
if [ $RESULT = OK ]; then
  # update git
  git add .
  echo -n "Enter commit message for git, e.g. upgrade to ver.x.x.x : "
  read MESSAGE
  git commit -m "$MESSAGE"
  git push origin master && \
  # update gae
  appcfg.py update ~/Workspace/wordpress_gae/ && \
  echo "upgrade successfully completed!"
else
  echo "Stopping script as the message was not entered as \"OK\"."
  echo "
  "
fi

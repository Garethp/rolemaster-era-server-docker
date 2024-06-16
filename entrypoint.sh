#!/usr/bin/env bash

if [ ! -d "/srv/ERA-Linux" ]; then
    echo "Please mount the ERA-Linux directory to /srv/ERA-Linux"
    exit 1
fi

if [ -z "${MODULE}" ]; then
    echo "Please set the MODULE environment variable to be the module you want this ERA to run for"
    exit 1
fi

if [ -d /opt/ERA-Linux ]; then
    rm -rf /opt/ERA-Linux
fi

cp -R /srv/ERA-Linux /opt/ERA-Linux
rm -rf "/opt/ERA-Linux/$MODULE/Characters"
rm -rf /opt/ERA-Linux/Server/ERA-Settings.ini
rm -rf /opt/ERA-Linux/Server/ERA-Server.state
ln -s /srv/Characters "/opt/ERA-Linux/$MODULE/Characters"
ln -s /srv/ERA-Linux/Server/ERA-Settings.ini /opt/ERA-Linux/Server/ERA-Settings.ini
ln -s /srv/ERA-Linux/Server/ERA-Server.state /opt/ERA-Linux/Server/ERA-Server.state

if [ ! -z "${EXTRA_MODULES}" ]; then
  modules=$(echo $EXTRA_MODULES | tr ";" "\n")

  for extra_module in $modules
  do
      if [ ! -d "/srv/Modules/$extra_module" ]; then
          echo "Please mount the $extra_module directory to /srv/Modules/$extra_module"
          exit 1
      fi

      cd "/srv/Modules/$extra_module"
      cp -R ./* "/opt/ERA-Linux"
      cd -
  done
fi

bash /opt/ERA-Linux/Server/ERA-Server.sh "$MODULE"
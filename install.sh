#!/usr/bin/env bash

DIR="${HOME}/.config/polybar/"
REPO="https://raw.githubusercontent.com/2x02/polybar/main/"

curlFrom () {
  curl -O "$1" || echo "Download failed!"
}

download () {
  mkdir -p ${DIR}

  (
    cd ${DIR}

    curl --remote-name "${REPO}"config \
         --remote-name "${REPO}"launch.sh \
  )
}

startInstall () {
  ping www.archlinux.org -i 0.2 -c 5 || { echo "No connection..."; exit 1; }
  download
  echo
  echo "YaY!"
  echo "Done :)"
}

type curl >/dev/null 2>&1 || {
  echo "Please make sure to have \"curl\"  on your machine."
  exit 1
}

if [ "$#" != "0" -a "$#" != 1 ]; then
  echo "Invalid number of arguments."
  exit 1
fi

if [ "$#" == "1" ]; then
  if [ "$1" == "--yes" ]; then
    startInstall
    exit 0;
  else
    echo "Invalid argument."
    exit 1
  fi
fi

if [ -d "$DIR" ]; then
  echo "${DIR} directory already exists."
  while true; do
      read -p "Do you want to delete it (yes/no)?" yn
      case $yn in
          YES | Yes | yes | [Yy])
            startInstall
            break;;
          NO  | No  | no  | [Nn])
            echo "Abort...";
            exit;;
          *   )
            echo "Please answer yes or no.";;
      esac
  done
else
  echo "Downloading from Github..."
  startInstall
fi


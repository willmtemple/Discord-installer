#!/bin/bash

name=$1
lowercase_name=$2
url=$(curl -sI "$3" | grep location | cut -d' ' -f2 | dos2unix)
version=$(echo $url | egrep -o "$lowercase_name-[0-9.]+[0-9]" | grep -Eo [0-9.]+)
rebuild=false
rebuild_trigger="/var/lib/discord-installer-rebuild-$name"

rpm -qi $name &> /dev/null

if [[ $? = 0 ]] && [[ $(rpm -q --queryformat '%{VERSION}' $name) = $version ]]
then
    if [[ -f $rebuild_trigger ]]
    then
        rebuild=true
    else
        exit 0
    fi
fi

export HOME=/tmp/discord-installer
mkdir -p $HOME
rpmdev-setuptree

cp /usr/share/discord-installer/template.spec $HOME/rpmbuild/SPECS/$name.spec
pushd $HOME/rpmbuild/SPECS

sed -i "s,\[name\],$name,"                      $name.spec
sed -i "s,\[lowercase_name\],$lowercase_name,"  $name.spec
sed -i "s,\[url\],$url,"                        $name.spec
sed -i "s,\[version\],$version,"                $name.spec

spectool -g -C ../SOURCES $name.spec
rpmbuild -bb $name.spec

pkcon install-local --allow-reinstall -y ../RPMS/$(uname -p)/*.rpm

popd
rm -r $HOME

if [[ -f $rebuild_trigger ]]
then
    rm -f $rebuild_trigger
fi

who | while read line
do
    pkexec --user $(echo $line | cut -d' ' -f1) notify-send --icon $2 "$1 updated to version $version"
done

exit 0
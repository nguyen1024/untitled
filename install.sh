#!/usr/bin/env bash
# Needs to be on the first line.
# Specify bash shell.

echo //------------------------------------------------------------------------------
echo //
echo // To update resolve.conf
echo //
echo //------------------------------------------------------------------------------

sudo ifdown ens160
sudo ifup ens160

echo //------------------------------------------------------------------------------
echo //
echo // Prevent warning message.
echo //
echo //------------------------------------------------------------------------------

## (http://serverfault.com/questions/500764/dpkg-reconfigure-unable-to-re-open-stdin-no-file-or-directory)
export DEBIAN_FRONTEND=noninteractive

echo //------------------------------------------------------------------------------
echo //
echo // Retrieve new list of packages.
echo //
echo //------------------------------------------------------------------------------

sudo apt-get update

echo //------------------------------------------------------------------------------
echo //
echo // Install Emacs.
echo //
echo //------------------------------------------------------------------------------

sudo apt-get install -y emacs24

echo //------------------------------------------------------------------------------
echo //
echo // Install Terminator.
echo //
echo //------------------------------------------------------------------------------

sudo apt-get install -y terminator

#echo //------------------------------------------------------------------------------
#echo //
#echo // Install Subversion.
#echo //
#echo //------------------------------------------------------------------------------

#sudo apt-get install -y subversion

echo //------------------------------------------------------------------------------
echo //
echo // Install Git.
echo //
echo //------------------------------------------------------------------------------

sudo apt-get install -y git

#echo //------------------------------------------------------------------------------
#echo //
#echo // Install C shell.
#echo //
#echo //------------------------------------------------------------------------------

## http://unix.stackexchange.com/questions/140286/how-to-find-list-of-available-shells-by-command-line

#sudo apt-get install -y csh

echo //------------------------------------------------------------------------------
echo //
echo // Install gl development ools.
echo //
echo // To fix Qt5Gui_GL_LIBRARY-NOTFOUND
echo //
echo //------------------------------------------------------------------------------

sudo apt-get install -y libgl1-mesa-dev

echo //------------------------------------------------------------------------------
echo //
echo // Install Trash.
echo //
echo //------------------------------------------------------------------------------

sudo apt-get install -y trash-cli

echo //------------------------------------------------------------------------------
echo //
echo // Install 7-zip.
echo //
echo //------------------------------------------------------------------------------

sudo apt-get install -y p7zip-full

echo //------------------------------------------------------------------------------
echo //
echo // Install ntp.
echo //
echo // To prevent clock skewed detected.
echo //
echo //------------------------------------------------------------------------------

sudo apt-get install -y ntp

## https://askubuntu.com/questions/3375/how-to-change-time-zone-settings-from-the-command-line
echo // Set the time zone.
sudo timedatectl set-timezone Australia/Melbourne

#echo //------------------------------------------------------------------------------
#echo //
#echo // Install Geospatial Data Abstraction Library.
#echo //
#echo //------------------------------------------------------------------------------

#sudo apt-get install -y libgdal-dev

echo //------------------------------------------------------------------------------
echo //
echo // To remve packages that are no longer needed.
echo //
echo //------------------------------------------------------------------------------

sudo apt autoremove -y

echo //------------------------------------------------------------------------------
echo //
echo // Set environment variables.
echo //
echo //------------------------------------------------------------------------------

## Set environment variables.
## http://stackoverflow.com/questions/24707986/create-linux-environment-variable-using-vagrant-provisioner

## Modify vagrant bashrc instead of root bashrc.
## http://stackoverflow.com/questions/27026015/update-bashrc-from-provisioning-shell-script-with-vagrant

## Do string contains in bash.
## http://stackoverflow.com/questions/30557508/bash-checking-if-string-does-not-contain-other-string

## Use double square brackets.
## http://stackoverflow.com/questions/229551/string-contains-in-bash

##
source /home/vagrant/.profile

## Set CBDI_ROOT.
#LOCAL_CBDI_ROOT=/vagrant/cbdi
#if [ -z "$CBDI_ROOT" ] || [ "$CBDI_ROOT" != "$LOCAL_CBDI_ROOT" ]; then
    #echo "export CBDI_ROOT=$LOCAL_CBDI_ROOT" >> /home/vagrant/.bashrc
    #echo "export CBDI_ROOT=$LOCAL_CBDI_ROOT" >> /home/vagrant/.profile
#fi

## Set IBA_ROOT.
#LOCAL_IBA_ROOT=/vagrant/iba
#if [ -z "$IBA_ROOT" ] || [ "$IBA_ROOT" != "$LOCAL_IBA_ROOT" ]; then
    #echo "export IBA_ROOT=$LOCAL_IBA_ROOT" >> /home/vagrant/.bashrc
    #echo "export IBA_ROOT=$LOCAL_IBA_ROOT" >> /home/vagrant/.profile
#fi

## Use display gui in display 0
if [ -z "$DISPLAY" ] || [ "$DISPLAY" != ":0" ]; then
    echo "export DISPLAY=:0" >> /home/vagrant/.bashrc
    echo "export DISPLAY=:0" >> /home/vagrant/.profile
fi

## Get the current path.
LOCAL_PATH=$PATH

## Add ccache to the path.
if [ -z "$PATH" ] || [[ "$PATH" != *"/usr/lib/ccache"* ]]; then
    LOCAL_PATH=/usr/lib/ccache:$LOCAL_PATH
fi

## Add C-BDI bin
#CBDI_BIN=$LOCAL_CBDI_ROOT/bin
#if [ -z "$PATH" ] || [[ "$PATH" != *"$CBDI_BIN"* ]]; then
    #LOCAL_PATH=$CBDI_BIN:$LOCAL_PATH
#fi

## Add C-BDI tools to the path.
#CBDI_TOOLS=$LOCAL_CBDI_ROOT/tools
#if [ -z "$PATH" ] || [[ "$PATH" != *"$CBDI_TOOLS"* ]]; then
    #LOCAL_PATH=$CBDI_TOOLS:$LOCAL_PATH
#fi

## Add qmake to the path.
QMAKE_PATH=/home/vagrant/Qt/5.9/gcc_64/bin
if [ -z "$PATH" ] || [[ "$PATH" != *"$QMAKE_PATH"* ]]; then
    LOCAL_PATH=$QMAKE_PATH:$LOCAL_PATH
fi

##
if [ "$LOCAL_PATH" != "$PATH" ]; then
    ##
    echo "export PATH=$LOCAL_PATH" >> /home/vagrant/.bashrc
    echo "export PATH=$LOCAL_PATH" >> /home/vagrant/.profile
fi

##
source /home/vagrant/.profile

echo //------------------------------------------------------------------------------
echo //
echo // Install Qt.
echo //
echo //------------------------------------------------------------------------------

## Get Qt source files.
if [ ! -f "/vagrant/3rd_party/qt-opensource-linux-x64-5.9.3.run" ]; then
    echo // Go to 3rd_party directory.
    pushd /vagrant/3rd_party

    echo // Downloading Qt.
    wget -continue https://download.qt.io/archive/qt/5.9/5.9.3/qt-opensource-linux-x64-5.9.3.run

    echo // Go to the previous directory.
    popd
fi

## http://stackoverflow.com/questions/25105269/silent-install-qt-run-installer-on-ubuntu-server
## http://stackoverflow.com/questions/646930/cannot-connect-to-x-server-0-0-with-a-qt-application
## http://stackoverflow.com/questions/59838/check-if-a-directory-exists-in-a-shell-script

## Xvfb failed start error
## https://stackoverflow.com/questions/16726227/xvfb-failed-start-error
## To overcome Xvfb failed start error.
## To use another number if the current one is busy.
## --auto-servernum
##
## For reference.
## #xvfb-run --auto-servernum ./qt-opensource-linux-x64-5.7.0.run --script ../iwd/qt-installer-noninteractive.qs --verbose -platform minimal

## Silent install Qt run installer on ubuntu server
## https://stackoverflow.com/questions/25105269/silent-install-qt-run-installer-on-ubuntu-server
## To overcome paint errors.
## -platform minimal
##
## The Unknown option: p, l, a, t, f, o, r, m message is incorrectly printed
## (it's a bug). The command still succeeds.

if [ ! -d "/home/vagrant/Qt" ]; then
    sudo apt-get install -y xvfb
    export DISPLAY=:0
    cd /vagrant/iba
    chmod u+x /vagrant/3rd_party/qt-opensource-linux-x64-5.9.3.run
    /vagrant/3rd_party/qt-opensource-linux-x64-5.9.3.run --script qt-installer-noninteractive.qs --verbose -platform minimal
    cd -
fi

#echo //------------------------------------------------------------------------------
#echo //
#echo // Start in specified directory.
#echo //
#echo //------------------------------------------------------------------------------

## http://www.grymoire.com/Unix/Sed.html
## http://stackoverflow.com/questions/17864047/automatically-chdir-to-vagrant-directory-upon-vagrant-ssh
## http://stackoverflow.com/questions/3557037/appending-a-line-to-a-file-only-if-it-does-not-already-exist

#grep -q -F 'cd /vagrant//iba' /home/vagrant/.bashrc || echo 'cd /vagrant/iba' >> /home/vagrant/.bashrc

#echo //------------------------------------------------------------------------------
#echo //
#echo // Required by C-BDI.
#echo //
#echo //------------------------------------------------------------------------------

## http://stackoverflow.com/questions/37550993/rstudio-installation-failure-under-debian-sid-libgstreamer-dependency-problems

#sudo apt-get install -y libgstreamer0.10-0 libgstreamer-plugins-base0.10-0

echo //------------------------------------------------------------------------------
echo //
echo // Install MySQL
echo //
echo //------------------------------------------------------------------------------

## https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-16-04
## How to instal MySQL
## https://stackoverflow.com/questions/7739645/install-mysql-on-ubuntu-without-password-prompt
## How to automate the install.
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
sudo apt-get install -y mysql-server

#sudo -E apt-get install -q -y mysql-server

## https://askubuntu.com/questions/82374/how-do-i-start-stop-mysql-server
sudo /etc/init.d/mysql start

## If you install 5.7 and don’t provide a password to the root user, it will
## use the auth_socket plugin. That plugin doesn’t care and doesn’t need a
## password. It just checks if the user is connecting using a UNIX socket and
## then compares the username.
## https://askubuntu.com/questions/766334/cant-login-as-mysql-user-root-from-normal-user-account-in-ubuntu-16-04
## https://stackoverflow.com/questions/8055694/how-to-execute-a-mysql-command-from-a-shell-script
#echo sudo mysql -u root -Bse "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';"
#sudo mysql -u root -Bse "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';"

sudo apt-get install mysql-client

#echo //------------------------------------------------------------------------------
#echo //
#echo // Backup the database.
#echo //
#echo //------------------------------------------------------------------------------

#echo // Go to the database directory.
#pushd /vagrant/iba/db

#echo // Backup the database.
#echo // Get current date and time.
#TODAY=`date '+%Y_%m_%d_%H_%M_%S'`;
#mysql -uroot -ppassword iba > iba.sql.$TODAY

#echo // Drop the database.
#mysql -uroot -ppassword -Bse "DROP DATABASE iba;"

#echo // Create a database.
#mysql -uroot -ppassword -Bse "CREATE SCHEMA iba;"

#echo // Populate the database.
#mysql -uroot -ppassword iba < iba.sql

#echo // Go to the previous directory.
#popd

#echo //------------------------------------------------------------------------------
#echo //
#echo // Build the Qt SQL driver.
#echo //
#echo //------------------------------------------------------------------------------

## Create a symbolic link.
## https://stackoverflow.com/questions/638975/how-do-i-tell-if-a-regular-file-does-not-exist-in-bash
#if [ ! -f /usr/lib/x86_64-linux-gnu/libmysqlclient_r.so ]; then
    #pushd /usr/lib/x86_64-linux-gnu
    #sudo ln -s libmysqlclient.so libmysqlclient_r.so
    #popd
#fi

## Get Qt source files.
#if [ ! -f "/vagrant/3rd_party/qt-everywhere-opensource-src-5.7.0.zip" ]; then
    #echo // Go to the 3rd_party directory.
    #pushd /vagrant/3rd_party

    ## https://www.cyberciti.biz/tips/wget-resume-broken-download.html
    #echo // Download Qt source files.
    #wget -continue https://download.qt.io/archive/qt/5.7/5.7.0/single/qt-everywhere-opensource-src-5.7.0.zip

    #echo // Go to the previous directory.
    #popd
#fi

## Unzip Qt source files.
#if [ ! -d "/vagrant/3rd_party/qt-everywhere-opensource-src-5.7.0" ]; then
    #pushd /vagrant/3rd_party
    #7z x qt-everywhere-opensource-src-5.7.0.zip
    #popd
#fi

#echo // Change to source directory.
#pushd /vagrant/3rd_party/qt-everywhere-opensource-src-5.7.0/qtbase/src/plugins/sqldrivers/mysql

#echo // Generate Makefile.
#qmake "INCLUDEPATH+=/usr/local/include /usr/local/include/mysql" "LIBS+=-L/usr/local/lib -L/usr/lib/x86_64-linux-gnu -lmysqlclient"

#echo // Make.
#make

#echo // Change to SQL driver directory.
#pushd /home/vagrant/Qt/5.7/gcc_64/plugins/sqldrivers

## https://unix.stackexchange.com/questions/57590/appending-a-current-date-from-a-variable-to-a-filename
#echo // Get current date and time.
#TODAY=`date '+%Y_%m_%d_%H_%M_%S'`;

#echo // Backup SQL driver.
#mv libqsqlmysql.so libqsqlmysql.so.$TODAY

#echo // Copy SQL driver.
#cp /vagrant/3rd_party/qt-everywhere-opensource-src-5.7.0/qtbase/plugins/sqldrivers/libqsqlmysql.so .

#echo // Go to previous directory.
#popd

#echo // Go to previous directory.
#popd

echo //------------------------------------------------------------------------------
echo //
echo // Install MySQL Workbench
echo //
echo //------------------------------------------------------------------------------

## https://askubuntu.com/questions/873360/mysql-workbench-on-ubuntu-16-04
sudo apt-get install -y mysql-workbench

echo //------------------------------------------------------------------------------
echo //
echo // End.
echo //
echo //------------------------------------------------------------------------------

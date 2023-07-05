#!/bin/bash

export JOBS=`nproc`;

if [[ ${1} = "--auto" ]]; then
  export PARAM=-y
  export SKIP=1
else
  export PARAM=""
  export SKIP=0
fi

clear


if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Entering SCRIPT FILE'S DOWNLOAD Directory"
echo
if [ ! -d ~/tr-be-script ]; then
  mkdir -p ~/tr-be-script
fi
cd ~/tr-be-script

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing Python..."
echo
sudo apt-get install build-essential gcc $PARAM
wget http://www.python.org/ftp/python/3.3.2/Python-3.3.2.tgz
tar -xvzf Python-3.3.2.tgz
cd ~/tr-be-script/Python-3.3.2
./configure --prefix=/usr/local/python3.3
make -j${JOBS}
sudo make install -j${JOBS}
sudo ln -s /usr/local/python3.3/bin/python /usr/bin/python3.3
cd ~/tr-be-script

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. Skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing CCache..."
echo
wget http://www.samba.org/ftp/ccache/ccache-3.1.9.tar.gz
tar -xvzf ccache-3.1.9.tar.gz
cd ~/tr-be-script/ccache-3.1.9
./configure
make -j${JOBS}
sudo make install -j${JOBS}
echo "export USE_CCACHE=1" >> ~/.bashrc
ccache -M 25G
cd ~/tr-be-script

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. Skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing JDK 6..."
echo
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java6-installer
java -version

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. Skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing GNU Make..."
echo
cd ~/tr-be-script
wget http://ftp.gnu.org/gnu/make/make-3.82.tar.gz
tar -xvzf make-3.82.tar.gz
cd ~/tr-be-script/make-3.82
./configure
sudo make install -j${JOBS}
cd ~/

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. Skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing Required Packages..."
echo
sudo apt-get install git-core gnupg flex bison gperf build-essential \
zip curl zlib1g-dev libc6-dev libncurses5-dev x11proto-core-dev \
libx11-dev libreadline6-dev libgl1-mesa-dev tofrodos python-markdown \
libxml2-utils xsltproc pngcrush gcc-multilib lib32z1 schedtool \
libqt4-dev lib32stdc++6 libx11-dev:i386 g++-multilib lib32z1-dev \
lib32ncurses5-dev ia32-libs mingw32 lib32z-dev

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. Skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Adding terminal to mouse right click context menu..."
echo
sudo apt-get install nautilus-open-terminal $PARAM
nautilus -q

echo
echo "Installing GIT..."
echo
sudo apt-get install git $PARAM

echo
echo "Installing Repo..."
echo
if [ ! -d ~/bin ]; then
  mkdir -p ~/bin
fi
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo
echo "Installing ADB Drivers..."
echo
wget http://www.broodplank.net/51-android.rules
sudo mv -f 51-android.rules /etc/udev/rules.d/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. Skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Downloading and Configuring Android SD..."
echo "Making sure unzip is installed..."
echo
sudo apt-get install unzip $PARAM

if [ `getconf LONG_BIT` = "64" ]
then
        echo
        echo "Downloading SDK for 64bit Linux System..."
        wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20131030.zip
        echo "Download Complete!"
        echo "Extracting..."
        mkdir ~/adt-bundle
        mv adt-bundle-linux-x86_64-20131030.zip ~/adt-bundle/adt_x64.zip
        cd ~/adt-bundle
        unzip adt_x64.zip
        mv -f adt-bundle-linux-x86_64-20131030/* .
        echo "Configuring environment..."
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
        echo "Placing desktop shortcuts"
        ln -s ~/adt-bundle/eclipse/eclipse ~/Desktop/Eclipse
        ln -s ~/adt-bundle/sdk/tools/android ~/Desktop/SDK-Manager
        echo "Done!"
else

        echo
        echo "Downloading SDK for 32bit Linux System..."
        wget http://dl.google.com/android/adt/adt-bundle-linux-x86-20131030.zip
        echo "Download Complete!"
        echo "Extracting..."
        mkdir ~/adt-bundle
        mv adt-bundle-linux-x86-20131030.zip ~/adt-bundle/adt_x86.zip
        cd ~/adt-bundle
        unzip adt_x86.zip
        mv -f adt-bundle-linux-x86_64-20131030/* .
        echo "Configuring environment..."
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
        echo "Placing desktop shortcuts"
        ln -s ~/adt-bundle/eclipse/eclipse ~/Desktop/Eclipse
        ln -s ~/adt-bundle/sdk/tools/android ~/Desktop/SDK-Manager
        echo "Done!"
fi

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. Skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing DSIXDA's Android Kitchen..."
echo
cd ~/tr-be-script
wget https://github.com/dsixda/Android-Kitchen/archive/master.zip
unzip master.zip
mv -f Android-Kitchen-master ~/Android-Kitchen
echo -e '\n#!/bin/bash\ncd ~/Android-Kitchen\n./menu' >> ~/Android-Kitchen/kitchen
chmod 755 ~/Android-Kitchen/kitchen
ln -s ~/Android-Kitchen/kitchen ~/bin/kitchen
ln -s ~/Android-Kitchen/kitchen ~/Desktop/Android-Kitchen

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. Skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Cleaning up temporary files..."
echo
rm -f ~/tr-be-script/Python-3.3.2.tgz
sudo rm -rf ~/tr-be-script/Python-3.3.2
rm -f ~/tr-be-script/make-3.82.tar.gz
rm -rf ~/tr-be-script/make-3.82
rm -f ~/tr-be-script/ccache-3.1.9.tar.gz
rm -rf ~/tr-be-script/ccache-3.1.9
rm -rf ~/adt-bundle/adt-bundle-linux-x86_64-20131030
rm -rf ~/adt-bundle/adt-bundle-linux-x86-20131030
rm -f ~/adt-bundle/adt_x64.zip
rm -f ~/adt-bundle/adt_x86.zip
rm -f ~/tr-be-script/master.zip

clear

echo
echo "Done cleaning the kitchen!"
echo
echo "Time to make some lunch!"
echo 
#============================================================
# Please edit the below if you intend to build a different
# version of Android.
#
# To aim for builds without the added time of dealing with
# ASLR, point the repo init at gingerbread or honeycomb.
#
# You can also change your jN argument for parallel tasks
# for a faster build if you like. This was all done from
# gutless VMs, so default is set to 4.
#
# This script is unlicensed, but I ask that you please
# link back to me if you use it for a project that way
# I can merge changes and know if it's helping people
#
#============================================================
echo 
repo init -u https://android.googlesource.com/platform/manifest -b android-4.0.1_r1
echo
echo "Repo init done!"
echo 
read -p "Press [Enter] key to continue to building..."
echo 

clear

repo sync; . build/envsetup.sh; lunch full-eng; make -j4
echo 
echo "Android build done!"
echo 
read -p "Press [Enter] key to continue to notes..."
echo 

clear

echo
echo "Thanks for using this script!"
echo 
echo "You are now ready to run the emulator!"
echo 
echo
echo "Credits:"
echo 
echo "Original script by"
echo "> [T E A M  R A D I U M] <"
echo 
echo "Modifications for Android emu building for Vita WebKit research by"
echo "> josh_axey < "
echo 
echo "Once you exit from here, type emulator into your terminal to run"

read -p "Press [Enter] key to exit..."
exit

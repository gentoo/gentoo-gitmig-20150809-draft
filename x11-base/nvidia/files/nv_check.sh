#!/bin/sh

# NDIC Version 1.2
# By Will Weisser (waw0573@rit.edu)
#
# Revision history:
#
# 1.2: July 23, 2000 check /etc/X11/XF86Config-4 first, don't recommend
#                    removing /usr/X11R6/lib/lib*GLU.so.*
#
# 1.1: April 29, 2000 Added checking for /dev files
#
# 1.0: April 28, 2000 Initial revision
#
#

echo "Welcome to the NVidia Driver Installation Checker."
echo "This shell script is meant to help you debug your installation"
echo "of the beta NVidia Linux drivers.  It is not 100% foolproof."
echo "In particular, you will definitely want to make sure you have"
echo "the correct options in your XF86Config to make X work properly."
echo "This script cannot debug your X setup. That being said, it"
echo "should prove useful if are having problems with the drivers and"
echo "want to check the validity of your driver install."
echo ""
echo "At no time will this script EVER make changes to your system."
echo "It is simply a diagnostic tool - fixes of any kind will have to"
echo "come from you."
echo ""
echo "Press enter to continue..."

read

echo "OK, the first thing we need to do is make sure your XF86Config file"
echo "is set up correctly.  In order to do this, I'm first going to try"
echo "and find where this file might be..."

FOUND=""

echo "checking /usr/X11R6/lib/X11/XF86Config..."
if [ -r /usr/X11R6/lib/X11/XF86Config ]; then
	echo "found"
    XF86FILE="/usr/X11R6/lib/X11/XF86Config"
	FOUND="1"
else
	echo "not found"
fi

echo "checking /usr/X11R6/etc/X11/XF86Config..."
if [ -r /usr/X11R6/etc/X11/XF86Config ]; then
	echo "found"
    XF86FILE="/usr/X11R6/etc/X11/XF86Config"
	FOUND="1"
else
	echo "not found"
fi

echo "checking /etc/XF86Config..."
if [ -r /etc/XF86Config ]; then
	echo "found"
    XF86FILE="/etc/XF86Config"
	FOUND="1"
else
	echo "not found"
fi

echo "checking /etc/X11/XF86Config..."
if [ -r /etc/X11/XF86Config ]; then
	echo "found"
    XF86FILE="/etc/X11/XF86Config"
	FOUND="1"
else
	echo "not found"
fi

echo "checking /etc/X11/XF86Config-4..."
if [ -r /etc/X11/XF86Config-4 ]; then
	echo "found"
    XF86FILE="/etc/X11/XF86Config-4"
	FOUND="1"
else
	echo "not found"
fi

if [ -z $FOUND ] ; then
	echo "I couldn't find an XF86Config file anywhere! Either you haven't set"
	echo "up X at all, the file is not readable by you, or your file is in a"
	echo "non-standard place.  If the latter is the case, then make a symlink"
	echo "to a standard place and run this script again."
	exit
fi

echo "I'm going to be doing my checking using $XF86FILE.  If this is not"
echo "actually your X config, then quit this script with Ctrl-C, remove"
echo "or rename the file, then run this script again."
echo "Press enter to continue"

read

echo "I'm going to check your XF86Config file for the following things:"
echo "1) Loading the GLcore and glx modules"
echo "2) Specifying the nvidia driver instead of nv"

REGEXP1='Load[[:space:]]*\"glx\"'
REGEXP3='Driver[[:space:]]*\"nvidia\"'

echo ""
echo "Checking for the Load glx statement..."
if ! cat $XF86FILE | sed -e 's/#.*//' | grep $REGEXP1 ; then
	echo "You don't seem to have the statement: Load \"glx\""
    echo "in the Module section of your XF86Config!  By default it"
    echo "is there, so if you removed it, replace it, then run this"
    echo "script again."
    exit
fi

echo "It seems to be intact.  Now lets see if you're loading the correct"
echo "video driver..."
if ! cat $XF86FILE | sed -e 's/#.*//' | grep $REGEXP3  ; then
	echo "You don't seem to have the statement: Driver \"nvidia\""
    echo "in the Device section of your XF86Config! It is possible that"
    echo "you are using the \"nv\" module instead.  If this is the case,"
    echo "then replace \"nv\" with \"nvidia\" and run this script again."
    exit
fi
echo "Everything seems fine in your X config file.  This is not 100%"
echo "guaranteed to be accurate, but lets continue anyway (press enter)..."

read

echo "The next step involves making sure you have the proper files in"
echo "the right places, and that the kernel module loaded correctly."
echo "Press enter to begin the test."

read

echo "First lets make sure you don't have the old modules still present"
echo "by mistake..."
echo "Checking /usr/X11R6/lib/modules/extensions/libglx.a..."
if [ -f /usr/X11R6/lib/modules/extensions/libglx.a ] ; then
	echo "You seem to have a libglx.a file in your /usr/X11R6/lib/modules/extensions"
    echo "directory.  This will most likely cause a conflict with the"
    echo "current drivers.  Remove or rename this file, then run this"
    echo "script again."
	exit
fi
echo "Checking /usr/X11R6/lib/modules/extensions/libGLcore.a..."
if [ -f /usr/X11R6/lib/modules/extensions/libGLcore.a ] ; then
	echo "You seem to have a libGLcore.a file in your /usr/X11R6/lib/modules/extensions"
    echo "directory.  This will most likely cause a conflict with the"
    echo "current drivers.  Remove or rename this file, then run this"
    echo "script again."
	exit
fi

echo "You don't appear to have any conflicting older drivers.  Now lets check"
echo "if the new driver files are in place..."
echo "Checking /usr/X11R6/lib/modules/drivers/nvidia_drv.o..."
if ! [ -f /usr/X11R6/lib/modules/drivers/nvidia_drv.o ] ; then
	echo "Your nvidia_drv.o file is missing! Please get this file from the"
    echo "NVIDIA_GLX package, and install it as indicated in the FAQ, then"
    echo "run this script again."
    exit
fi
echo "Checking /usr/X11R6/lib/modules/extensions/libglx.so..."
if ! [ -f /usr/X11R6/lib/modules/extensions/libglx.so ] ; then
	echo "Your libglx.so file is missing! Please get this file from the"
    echo "NVIDIA_GLX package, and install it as indicated in the FAQ, then"
    echo "run this script again."
    exit
fi
echo "Checking /usr/lib/libGL.so..."
if ! [ -f /usr/lib/libGL.so ] ; then
	echo "Your libGL.so file is missing! Please get this file from the"
    echo "NVIDIA_GLX package, and install it as indicated in the FAQ, then"
    echo "run this script again."
    exit
fi
if ! ldd /usr/lib/libGL.so | grep libGLcore ; then
	echo "Your libGL.so file does not seem to be the one from the"
    echo "NVIDIA_GLX package! You probably forgot to install the correct"
    echo "libGL.so and left an older copy instead.  Put the libGL.so file"
    echo "from the NVIDIA_GLX package in /usr/lib, then run this script"
    echo "again."
    exit
fi
echo "Checking /usr/lib/libGLcore.so.1..."
if ! [ -f /usr/lib/libGLcore.so.1 ] ; then
	echo "Your libGLcore.so.1 file is missing! Please get this file from the"
    echo "NVIDIA_GLX package, and install it as indicated in the FAQ, then"
    echo "run this script again."
    exit
fi
echo "All the files seem to exist.  Now I'm going to see if your kernel"
echo "module is loaded correctly..."
if ! grep NVdriver /proc/modules ; then
	echo "the NVdriver kernel module does not seem to be loaded.  The 3D"
    echo "drivers will not work without it...please compile it for your"
    echo "kernel, set it up to insert the module on boot, then run"
    echo "this script again."
    echo "Remember if you are having trouble compiling the module,"
    echo "try adding -D_LOOSE_KERNEL_NAMES to the Makefile."
    exit
fi
if ! [ -r /dev/nvidiactl ] || ! [ -w /dev/nvidiactl ] || ! [ -c /dev/nvidiactl ] ; then
	echo "The kernel device /dev/nvidiactl does not exist, is not a device,"
    echo "or does not have the proper permissions set.  This dev entry should"
    echo "have been created when you created the kernel module.  If you"
    echo "compiled the module by hand, you may have to create this device"
    echo "manually (major number 195, minor number 255).  After this is done,"
    echo "please run this script again."
    exit
fi 
if ! [ -r /dev/nvidia0 ] || ! [ -w /dev/nvidia0 ] || ! [ -c /dev/nvidia0 ] ; then
	echo "The kernel device /dev/nvidia0 does not exist, is not a device,"
    echo "or does not have the proper permissions set.  This dev entry should"
    echo "have been created when you created the kernel module.  If you"
    echo "compiled the module by hand, you may have to create this device"
    echo "manually (major number 195, minor number 0).  After this is done,"
    echo "please run this script again."
    exit
fi 

#devfs doesn't seem to have these nodes, so we disable these checks.

#if ! [ -r /dev/nvidia1 ] || ! [ -w /dev/nvidia1 ] || ! [ -c /dev/nvidia1 ] ; then
#	echo "The kernel device /dev/nvidia1 does not exist, is not a device,"
#    echo "or does not have the proper permissions set.  This dev entry should"
#    echo "have been created when you created the kernel module.  If you"
#    echo "compiled the module by hand, you may have to create this device"
#    echo "manually (major number 195, minor number 1).  After this is done,"
#    echo "please run this script again."
#    exit
#fi 
#if ! [ -r /dev/nvidia2 ] || ! [ -w /dev/nvidia2 ] || ! [ -c /dev/nvidia2 ] ; then
#	echo "The kernel device /dev/nvidia2 does not exist, is not a device,"
#    echo "or does not have the proper permissions set.  This dev entry should"
#    echo "have been created when you created the kernel module.  If you"
#    echo "compiled the module by hand, you may have to create this device"
#    echo "manually (major number 195, minor number 2).  After this is done,"
#    echo "please run this script again."
#    exit
#fi 
#if ! [ -r /dev/nvidia3 ] || ! [ -w /dev/nvidia3 ] || ! [ -c /dev/nvidia3 ] ; then
#	echo "The kernel device /dev/nvidia3 does not exist, is not a device,"
#    echo "or does not have the proper permissions set.  This dev entry should"
#    echo "have been created when you created the kernel module.  If you"
#    echo "compiled the module by hand, you may have to create this device"
#    echo "manually (major number 195, minor number 3).  After this is done,"
#    echo "please run this script again."
#    exit
#fi 
echo "Your kernel module seems to be OK! Way to go, we're almost there now!"
echo "Press enter to move on to the last test..."

read

echo "I'm going to check for duplicate OpenGL libraries on your system."
echo "Having such libraries can cause OpenGL applications to run incorrectly."
echo "Press enter to begin the test."

read

echo "Checking for libGL.so or libMesaGL.so in /lib, /usr/lib, /usr/local/lib,"
echo "and /usr/X11R6/lib..."
TEMP=`ls /lib/lib*GL.so* /usr/lib/libMesaGL.so* /usr/local/lib/lib*GL.so* /usr/X11R6/lib/lib*GL.so* 2> /dev/null`
if  ! [ -z "$TEMP" ] ; then
	echo "I found the following possible conflicting files:"
	echo `ls /lib/lib*GL.so* /usr/lib/libMesaGL.so* /usr/local/lib/lib*GL.so* /usr/X11R6/lib/lib*GL.so* 2> /dev/null`
	echo "Unless you know what you're doing, I recommend removing these files"
    echo "to prevent applications from using them instead of /usr/lib/libGL.so"
	exit
fi

echo "No conflicting files were found! Your installation appears to be OK!"
echo ""
echo "I've done all I can...if you've gotten this far and things are still"
echo "broken, then please e-mail linux-bugs@nvidia.com with your problem,"
echo "or stop by #nvidia on irc.openprojects.net for help."
echo "Don't forget that you must run /sbin/ldconfig after changing any"
echo "shared libraries!"
echo ""
echo "Have a nice day!"

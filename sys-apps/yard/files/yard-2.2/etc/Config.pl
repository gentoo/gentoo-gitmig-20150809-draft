# -*- Mode: Perl -*-
#
#  $Id: Config.pl,v 1.1 2002/08/25 20:25:33 aliz Exp $
#  CONFIG.PL - Configuration options for Yard.
#
#  Tailor these for your system.
#  These variables have to be in Perl syntax, which is simply:
#
#       $var = value;
#   or
#       @array = (value1, value2, ..., valueN);
#
#
##############################################################################
package CFG;

#  $verbosity: 1 or 0
#
#  This controls only what is printed to the screen.
#  0 --> only the important messages.
#  1 --> all messages.  
#  All messages will be written to the log file regardless of the setting.
#
$verbosity = 0;


#  $floppy:          string (device name)
#  $floppy_capacity: integer (kilobytes)
#
#  The floppy device where the rescue disk will be written and its
#  capacity.  Make sure the two agree.  If $floppy is a non-standard
#  size (eg, 1722K), make sure to use the complete name (eg, /dev/fd0H1722).
#
$floppy            = "/dev/fd0";
$floppy_capacity   = 1440;    # KB


#  $disk_set: string (one of "single", "double" or "base+extra")
#
#  single: Both the kernel and entire compressed root filesystem will
#  be put on one disk.
#
#  double: The kernel will be put on the first disk and the compressed
#  root fs will be put on the second.
#
#  base+extra: THIS OPTION NOT YET IMPLEMENTED.  The first disk will
#  contain the kernel plus a base set of files (enough to boot and run
#  tar).  The second disk will contain the remaining files.
#
$disk_set   = "double";


#  $mount_point: string (directory name)
#
#  A directory to be used as a mount point.  This is where the root
#  filesystem will be mounted during creation and where the floppy
#  will be mounted when the rescue disk is being written.
#  This directory must exist when the Yard scripts are run.
#
$mount_point	   = "/mnt/floppy";


#  $device: string (device name)
#
#  The device for building the filesystem.  This can be /dev/ram0 or a
#  spare partition.  You can turn off swapping temporarily and use the
#  swap partition on your hard disk.  You can use a loopback device if
#  your kernel supports them -- see the section "Using a Loopback
#  Device" in the Yard documentation for instructions.
#  It should not be a symbolic link.
#
$device =           "/dev/rd/0";


#  $fs_size: integer (kilobytes)
#
#  The size limit of $device, in Kbytes.  For most devices, Yard can
#  check this value against the available space.
#
$fs_size	   = 4096;	# KB


#  $kernel: string (filename)
#
#  The absolute filename of the compressed kernel to be put on the
#  rescue disk.  This should be the COMPRESSED kernel.  This is
#  usually something like /vmlinuz, /zImage or /boot/zImage.  If
#  you've just remade your kernel (via "make zImage") the kernel file
#  will reside in /usr/src/linux/arch/i386/boot/zImage
#
$kernel             = "/boot/vmlinuz";

# $kernel_version: string (version string)
#
#  make_root_fs will examine $kernel and try to determine its version.
#  If Yard guesses incorrectly, or you want to force it anyway, set
#  $kernel_version here.  The value should be a version string such as
#  that returned by "uname -r".
#
#$kernel_version = "2.2.15";


#  $contents_file: string (filename)
#
#  The file specifying the bootdisk contents specification file.
#
$contents_file	   = "/etc/yard/Bootdisk_Contents";


#  $rootfsz: string (filename)
#  The file that will temporarily hold the compressed root filesystem
#
$rootfsz          = "/tmp/root.gz";


#  $oldroot: absolute directory name
#
#  Where the old (hard disk) root filesystem will be mounted on the
#  ramdisk filesystem.  create_fstab uses this to adapt your
#  /etc/fstab for use on the rescue disk so you'll be able to mount
#  hard disk partitions more easily.  You shouldn't need to change
#  this, but run create_fstab.pl again if you do.
#
$oldroot = "/OLDROOT";


#  $strip_objfiles: 0 or 1
#
#  If set to 1, binary executables and libraries will be stripped
#  of their debugging symbols (using objcopy) as they're copied to the
#  root filesystem.  This may reduce their size somewhat.  If you don't
#  understand what this means, leave it at 1.  If you're sure you
#  don't have objcopy, or for some reason you want debugging symbols,
#  set it to 0.
#
$strip_objfiles = 1;


#  $yard_temp: string (directory name)
#
#  If non-null, specifies directory where .log and .ls files will be
#  written.  If null, log files will be written to current working
#  directory.
#
$yard_temp = "";


#  $use_lilo: 1 or 0
#
#  Whether to use Lilo for transferring the kernel to the boot disk.
#  1  => Yard will use Lilo to boot the kernel.  The configuration file is
#        created when you invoke "make", and ends up
#        in /etc/yard/Replacements/etc/lilo.conf.  This option
#        allows you to use Lilo's APPEND clause and various other Lilo
#        options.
#
#  0  => Yard will copy the kernel directly to the rescue disk.
#
$use_lilo = 0;


#  @additional_dirs: array of directory names
#
#  Any additional directories (besides those in $PATH) to be searched
#  for rescue disk files.  Directories inside the list must be
#  separated by commas.  You don't need a trailing slash on these
#  directory names.  NB. Any directories you list here will be
#  searched BEFORE those in $PATH.
#
@additional_dirs  = ( "/etc/fs",
		      "/etc/rc.d"
		    );


1;######################  End of Config.pl, put nothing below this line.

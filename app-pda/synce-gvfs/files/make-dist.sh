#!/bin/sh

gvfs_src_dir="/home/mark/sources/synce/gvfs/gvfs-1.0.2"
#gvfs_src_dir = @with_gvfs_source@


mkdir ../common
for i in "${gvfs_src_dir}/common/*.h"; do
  cp ${i}  ../common
done
cp -a common-Makefile.am ../common/Makefile.am


cp -a "${gvfs_src_dir}/daemon/gvfsdaemon.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsdaemon.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsbackend.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsbackend.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfschannel.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfschannel.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsreadchannel.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsreadchannel.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfswritechannel.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfswritechannel.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsmonitor.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsmonitor.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsdaemonutils.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsdaemonutils.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjob.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjob.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobsource.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobsource.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobdbus.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobdbus.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobmount.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobmount.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobunmount.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobunmount.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobmountmountable.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobmountmountable.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobunmountmountable.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobunmountmountable.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobopenforread.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobopenforread.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobread.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobread.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobseekread.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobseekread.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobcloseread.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobcloseread.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobopenforwrite.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobopenforwrite.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobwrite.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobwrite.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobseekwrite.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobseekwrite.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobclosewrite.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobclosewrite.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobpull.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobpull.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobpush.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobpush.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobqueryinfo.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobqueryinfo.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobqueryfsinfo.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobqueryfsinfo.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobenumerate.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobenumerate.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobsetdisplayname.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobsetdisplayname.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobtrash.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobtrash.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobdelete.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobdelete.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobcopy.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobcopy.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobmove.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobmove.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobmakedirectory.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobmakedirectory.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobmakesymlink.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobmakesymlink.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobsetattribute.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobsetattribute.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobqueryattributes.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobqueryattributes.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobcreatemonitor.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfsjobcreatemonitor.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/dbus-gmain.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/dbus-gmain.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfskeyring.h" ../daemon
cp -a "${gvfs_src_dir}/daemon/gvfskeyring.c" ../daemon

cp -a "${gvfs_src_dir}/daemon/daemon-main.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/daemon-main-generic.c" ../daemon
cp -a "${gvfs_src_dir}/daemon/daemon-main.h" ../daemon

cp -a daemon-Makefile.am ../daemon/Makefile.am


sed -i -e 's|daemon \\|daemon \\\n\tcommon \\|' ../Makefile.am

cp -a configure.ac.in ..

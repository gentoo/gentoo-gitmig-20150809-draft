# Distributed under the terms of the GNU General Public License v2
# /etc/conf.d/vservers - Defines which vservers are launched as well as the launch order
#
# Parts from lmsensors (Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>)
#
# This file is used by /etc/init.d/vservsers and defines the vservers to
# be started/stopped. This file is sourced into /etc/init.d/vservers.
#
# The format of this file is a shell script that simply defines the marks
# of vservers to be launched in order as normal variables with the special names:
#    MARK_0, MARK_1, MARK_2, etc.
#
# Please note that the numbers in MARK_X must start at 0 and increase in
# steps of 1. Any number that is missing will make the init script skip the
# rest of the marks. 
#
# If you want the vserver "foo" to belong to group "bar" of vservers, type the command:
# echo bar >/etc/vservers/foo/apps/init/mark
#
# 
MARK_0=default


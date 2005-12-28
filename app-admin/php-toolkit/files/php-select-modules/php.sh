#
# /usr/share/php-select/php.sh
#		Module to manage /usr/bin/php binary
#
#		Written for Gentoo Linux
#
# Author	Stuart Herbert
#		(stuart@gentoo.org)
#
# Copyright	(c) 2005 Gentoo Foundation, Inc.
#		Released under version 2 of the GNU General Public License
#
# ========================================================================

G_SYMLINK_SOURCE[0]="bin/php"
G_SYMLINK_TARGET[0]="/usr/bin/php"

. $G_MODULE_PATH/libsymlink.sh

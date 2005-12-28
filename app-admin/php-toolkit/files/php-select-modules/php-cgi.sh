#
# /usr/share/php-select/php-cgi.sh
#		Module to manage /usr/bin/php-cgi binary
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

G_SYMLINK_SOURCE[0]="bin/php-cgi"
G_SYMLINK_TARGET[0]="/usr/bin/php-cgi"

. $G_MODULE_PATH/libsymlink.sh

#
# /usr/share/php-select/php-devel.sh
#		Module to manage PHP development scripts
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

G_SYMLINK_SOURCE[0]="bin/php-config"
G_SYMLINK_TARGET[0]="/usr/bin/php-config"

G_SYMLINK_SOURCE[1]="bin/phpize"
G_SYMLINK_TARGET[1]="/usr/bin/phpize"

. $G_MODULE_PATH/libsymlink.sh

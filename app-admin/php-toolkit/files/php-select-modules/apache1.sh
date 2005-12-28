#
# /usr/share/php-select/apache1.sh
#		Module to manage mod_php for Apache2
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

G_APACHE_CONF=/etc/conf.d/apache
G_APACHE_INIT=/etc/init.d/apache
G_OPTS_VAR="APACHE_OPTS"
G_APACHE_MOD_DIR="/usr/lib/apache/modules"

. $G_MODULE_PATH/libapache.sh

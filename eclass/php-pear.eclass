# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php-pear.eclass,v 1.1 2003/12/23 11:00:01 coredumb Exp $
#
# Author: Tal Peer <coredumb@gentoo.org>
#
# The php-pear eclass provides means for easy installation of PEAR
# packages, see http://pear.php.net

# Note that this eclass doesn't handle PEAR packages' dependencies on
# purpose, please use (R)DEPEND to define them.

ECLASS=php-pear
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS src_install

# Set this is the the package name on PEAR is different than the one in
# portage (generally shouldn't be the case).
[ -z "$PHP_PEAR_PKG_NAME" ] && PHP_PEAR_PKG_NAME=${PN/PEAR-/}
PEAR_PN=${PHP_PEAR_PKG_NAME}-${PV}

[ -z "$SRC_URI" ] && SRC_URI="http://pear.php.net/get/${PEAR_PN}.tgz"
[ -z "$HOMEPAGE" ] && HOMEPAGE="http://pear.php.net/${PHP_PEAR_PKG_NAME}"

DEPEND="$DEPEND virtual/php"
RDEPEND="$RDEPEND $DEPEND"

S="${WORKDIR}/${PEAR_PN}"

php-pear_src_install () {
	cd ${S}
	mv ${WORKDIR}/package.xml ${S}
	pear install --nodeps -R ${D} ${S}/package.xml || die
}

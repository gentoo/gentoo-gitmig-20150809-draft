# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php-pear.eclass,v 1.7 2005/03/14 10:42:28 stuart Exp $
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

# We must depend on the virtual as well as the base package as we need it to do
# install tasks (it provides the pear binary).
DEPEND="$DEPEND >=dev-php/PEAR-PEAR-1.3.5-r1"
RDEPEND="$RDEPEND $DEPEND"

fix_PEAR_PV() {
	tmp=$PV
	tmp=${tmp/_/}
	tmp=${tmp/rc/RC}
	tmp=${tmp/beta/b}
	PEAR_PV=$tmp
}

PEAR_PV=""
fix_PEAR_PV
PEAR_PN=${PHP_PEAR_PKG_NAME}-${PEAR_PV}

[ -z "$SRC_URI" ] && SRC_URI="http://pear.php.net/get/${PEAR_PN}.tgz"
[ -z "$HOMEPAGE" ] && HOMEPAGE="http://pear.php.net/${PHP_PEAR_PKG_NAME}"
S="${WORKDIR}/${PEAR_PN}"

php-pear_src_install () {
	# SNMP is nuts sometimes
	addpredict /usr/share/snmp/mibs/.index

	cd ${S}
	mv ${WORKDIR}/package.xml ${S}
	pear install --nodeps -R ${D} ${S}/package.xml || die
}

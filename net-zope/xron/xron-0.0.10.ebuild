# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/xron/xron-0.0.10.ebuild,v 1.2 2003/12/14 23:36:33 spider Exp $

inherit zproduct

MY_PN="${PN/xron/Xron}"
MY_PV="${PV//./-}"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="Xron schedules and executes procedures for Zope applications"
HOMEPAGE="http://www.zope.org/Members/lstaffor/Xron"
SRC_URI="${HOMEPAGE}/${PV}/${MY_P}.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86"

ZPROD_LIST="Xron"
MYDOC="${MYDOC} *.txt"

src_install() {
	zproduct_src_install
	# fix permissions on files
	DIR=${D}/usr/share/zproduct/${PF}
	find ${DIR} -exec chown zope:root \{} \;
	find ${DIR} -exec chmod 644 \{} \;
	find ${DIR} -type d -exec chmod +x \{} \;
}


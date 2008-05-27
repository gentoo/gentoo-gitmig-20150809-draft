# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/exuserfolder/exuserfolder-0.20.0.ebuild,v 1.5 2008/05/27 05:55:51 tupone Exp $

inherit zproduct

MY_PN="exUserFolder"
MY_PN_DOWNLOAD="exuserFolder"
MY_PV="${PV//./_}"
MY_P="${MY_PN}-${MY_PV}"
MY_P_DOWNLOAD="${MY_PN_DOWNLOAD}-${MY_PV}"
DESCRIPTION="allows authentication via alternative methods + mysql plain text
auth patch"
HOMEPAGE="http://www.zope.org/Members/TheJester/exuserfolder"
SRC_URI="${HOMEPAGE}/${PV}/${MY_P_DOWNLOAD}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86"

S=${WORKDIR}

ZPROD_LIST="${MY_PN}"
MYDOC="${MYDOC} *.txt README.* LICENSE *.sql"

src_install() {
	zproduct_src_install
	# fix permissions on files
	DIR=${D}/usr/share/zproduct/${PF}
	find ${DIR} -exec chown zope:root \{} \;
	find ${DIR} -exec chmod 644 \{} \;
	find ${DIR} -type d -exec chmod +x \{} \;
}

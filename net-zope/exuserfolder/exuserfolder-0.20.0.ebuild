# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/exuserfolder/exuserfolder-0.20.0.ebuild,v 1.2 2003/12/05 20:24:03 lanius Exp $

inherit zproduct

MY_PN="exUserFolder"
MY_PN_DOWNLOAD="exuserFolder"
MY_PV="${PV//./_}"
MY_P="${MY_PN}-${MY_PV}"
MY_P_DOWNLOAD="${MY_PN_DOWNLOAD}-${MY_PV}"
DESCRIPTION="Extensible User Folder is a user folder that requires the authentication of users to be removed from the storage of properties of users"
HOMEPAGE="http://www.zope.org/Members/TheJester/${MY_PN}"
SRC_URI="${HOMEPAGE}/${PV}/${MY_P_DOWNLOAD}.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86"

ZPROD_LIST="${MY_PN}"
S="${WORKDIR}"
MYDOC="${MYDOC} *.txt README.* LICENSE *.sql"

src_install() {
	zproduct_src_install
	# fix permissions on files
	DIR=${D}/usr/share/zproduct/${PF}
	find ${DIR} -exec chown zope:root \{} \;
	find ${DIR} -exec chmod 644 \{} \;
	find ${DIR} -type d -exec chmod +x \{} \;
}


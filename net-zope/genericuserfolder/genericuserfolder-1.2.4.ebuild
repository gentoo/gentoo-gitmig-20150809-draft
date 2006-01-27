# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/genericuserfolder/genericuserfolder-1.2.4.ebuild,v 1.5 2006/01/27 02:34:37 vapier Exp $

inherit zproduct

MY_PN="GenericUserFolder"
MY_PV="${PV//./-}"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="The GenericUserFolder is a roll-your-own user folder"
HOMEPAGE="http://www.zope.org/Members/Zen/${MY_PN}"
SRC_URI="${HOMEPAGE}/${MY_PV}/${MY_P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86"

S=${WORKDIR}/lib/python/Products

ZPROD_LIST="${MY_PN}"
MYDOC="${MYDOC} *.txt"

src_install() {
	zproduct_src_install
	# fix permissions on files
	DIR=${D}/usr/share/zproduct/${PF}
	find ${DIR} -exec chown zope:root \{} \;
	find ${DIR} -exec chmod 644 \{} \;
	find ${DIR} -type d -exec chmod +x \{} \;
}

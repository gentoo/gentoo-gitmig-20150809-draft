# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/msnlib/msnlib-4.ebuild,v 1.1 2003/04/19 14:00:45 liquidx Exp $

inherit distutils

IUSE=""
DESCRIPTION="A Python MSN messenger protocol library and client"
HOMEPAGE="http://auriga.wearlab.de/~alb/"
SRC_URI="http://auriga.wearlab.de/~alb/files/${PN}-d${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=dev-lang/python-2.2"
S=${WORKDIR}/${PN}-d${PV}

src_install() {
    distutils_src_install
	cd ${S}
	dobin msn
	dobin msnsetup
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/openjms-bin/openjms-bin-0.7.5.ebuild,v 1.2 2003/12/18 20:56:35 lostlogic Exp $

SLOT=0
LICENSE="GPL-2"
DESCRIPTION="Open Java Messaging System"
DEPEND="virtual/glibc"
RDEPEND="virtual/jdk"
KEYWORDS="~x86"
SRC_URI="mirror://sourceforge/${PN/-bin/}/${P/-bin/}.tgz"

src_unpack() {
	einfo "Nothing to unpack"
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /opt
	cd ${D}/opt
	unpack ${A}
}

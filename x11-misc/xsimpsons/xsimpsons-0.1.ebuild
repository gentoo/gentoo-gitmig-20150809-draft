# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsimpsons/xsimpsons-0.1.ebuild,v 1.1 2003/04/22 20:46:44 sethbc Exp $

DESCRIPTION="The Simpsons walking along the tops of your windows."
HOMEPAGE="http://lightning.prohosting.com/~sbeyer/"
SRC_URI="http://lightning.prohosting.com/~sbeyer/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="x11-base/xfree"
RDEPEND=""
S=${WORKDIR}/${P}

src_compile() {
	make || die
}

src_install() {
	mkdir -p ${D}/usr/bin
	cp xsimpsons ${D}/usr/bin
}


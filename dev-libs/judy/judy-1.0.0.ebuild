# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/judy/judy-1.0.0.ebuild,v 1.1 2004/09/20 08:31:44 twp Exp $

inherit eutils

MY_P=Judy-${PV}
DESCRIPTION="A C library that implements a dynamic array"
HOMEPAGE="http://judy.sourceforge.net/"
SRC_URI="mirror://sourceforge/judy/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${MY_P}

src_compile() {
	econf --enable-32-bit
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}

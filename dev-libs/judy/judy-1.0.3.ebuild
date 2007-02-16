# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/judy/judy-1.0.3.ebuild,v 1.2 2007/02/16 07:56:00 opfer Exp $

inherit eutils libtool

MY_P=Judy-${PV}
DESCRIPTION="A C library that implements a dynamic array"
HOMEPAGE="http://judy.sourceforge.net/"
SRC_URI="mirror://sourceforge/judy/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
S=${WORKDIR}/${MY_P}

src_compile() {
	elibtoolize
	if ( use amd64 || use ia64 || use ppc64 ); then
		econf --enable-64-bit
	else
		econf --enable-32-bit
	fi
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}

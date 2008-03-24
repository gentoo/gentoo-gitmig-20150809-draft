# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/judy/judy-1.0.4.ebuild,v 1.1 2008/03/24 17:58:06 coldwind Exp $

inherit eutils libtool

MY_P=Judy-${PV}

DESCRIPTION="A C library that implements a dynamic array"
HOMEPAGE="http://judy.sourceforge.net/"
SRC_URI="mirror://sourceforge/judy/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_compile() {
	elibtoolize
	local myconf
	if use amd64 || use ia64 || use ppc64 ; then
		myconf="--enable-64-bit"
	else
		myconf="--enable-32-bit"
	fi

	econf ${myconf} || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}

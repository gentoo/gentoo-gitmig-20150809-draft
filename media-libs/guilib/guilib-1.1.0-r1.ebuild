# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/guilib/guilib-1.1.0-r1.ebuild,v 1.9 2005/08/26 12:29:29 flameeyes Exp $

inherit eutils

MY_P="GUIlib-${PV}"
DESCRIPTION="a simple widget set for SDL"
SRC_URI="http://www.libsdl.org/projects/GUIlib/src/${MY_P}.tar.gz"
HOMEPAGE="http://www.libsdl.org/projects/GUIlib/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc alpha ~hppa ~amd64"
IUSE=""

DEPEND=">=media-libs/libsdl-1.0.1"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.makefile.patch
}

src_compile() {
	econf --with-gnu-ld || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc CHANGES README
}

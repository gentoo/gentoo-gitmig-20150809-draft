# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/guilib/guilib-1.1.0.ebuild,v 1.6 2004/07/14 19:45:03 agriffis Exp $

MY_P="GUIlib-${PV}"
DESCRIPTION="a simple widget set for SDL"
SRC_URI="http://www.libsdl.org/projects/GUIlib/src/${MY_P}.tar.gz"
HOMEPAGE="http://www.libsdl.org/projects/GUIlib/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc"
IUSE="pic"

DEPEND=">=media-libs/libsdl-1.0.1"

S="${WORKDIR}/${MY_P}"

src_compile() {
	patch < ${FILESDIR}/${P}.makefile.patch

	econf --with-gnu-ld `use_with pic` || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc CHANGES README
}

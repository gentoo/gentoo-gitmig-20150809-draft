# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/guilib/guilib-1.1.0.ebuild,v 1.3 2004/02/20 10:27:42 mr_bones_ Exp $

MY_P="GUIlib-${PV}"
DESCRIPTION="a simple widget set for SDL"
SRC_URI="http://www.libsdl.org/projects/GUIlib/src/${MY_P}.tar.gz"
HOMEPAGE="http://www.libsdl.org/projects/GUIlib/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND=">=media-libs/libsdl-1.0.1"

S="${WORKDIR}/${MY_P}"

src_compile() {
	patch < ${FILESDIR}/${P}.makefile.patch

	econf --with-gnu-ld `use_with pic`
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc CHANGES README
}

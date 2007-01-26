# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.1.0.ebuild,v 1.3 2007/01/26 09:40:58 vapier Exp $

inherit eutils

DESCRIPTION="GL extrusion library"
HOMEPAGE="http://www.linas.org/gle"
SRC_URI="http://www.linas.org/gle/pub/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="doc"

DEPEND="virtual/opengl
	virtual/glu
	virtual/glut
	|| ( ( x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXmu
		x11-libs/libXt
	)
	<virtual/x11-7 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-amd64-skip-example.patch
}

src_compile() {
	# Replace inclusion of malloc.h with stdlib.h as needed by Mac OS X and
	# FreeBSD.
	sed -i -e 's:malloc.h:stdlib.h:g' src/*

	econf --with-x || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed."
	dodoc AUTHORS ChangeLog NEWS README
	use doc || rm -rf ${D}/usr/share/doc/gle
}

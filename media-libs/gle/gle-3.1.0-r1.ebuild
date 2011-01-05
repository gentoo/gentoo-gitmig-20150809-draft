# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.1.0-r1.ebuild,v 1.10 2011/01/05 07:14:34 xarthisius Exp $

inherit autotools multilib

DESCRIPTION="GL extrusion library"
HOMEPAGE="http://www.linas.org/gle"
SRC_URI="http://www.linas.org/gle/pub/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND="virtual/opengl
	virtual/glu
	media-libs/freeglut
	app-admin/eselect-opengl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Replace inclusion of malloc.h with stdlib.h as needed by Mac OS X and
	# FreeBSD. See bug #130340
	sed -i -e 's:malloc.h:stdlib.h:g' src/* || die

	# Don't build binary examples as they never get installed. See bug 141859
	sed -i -e 's:examples::' Makefile.am || die

	epatch "${FILESDIR}"/${P}-autotools.patch

	eautoreconf
}

src_compile() {
	econf --with-x --x-libraries=/usr/$(get_libdir)/opengl/xorg-x11

	if use doc; then
		sed -e 's:\$(datadir)/doc/gle:\$(datadir)/doc/${PF}:' \
			-i doc/Makefile || die
		sed -e 's:\$(datadir)/doc/gle/html:\$(datadir)/doc/${PF}/html:' \
			-i doc/html/Makefile || die
	fi

	emake || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die
	rm -rf "${D}"/usr/share/doc/gle
}

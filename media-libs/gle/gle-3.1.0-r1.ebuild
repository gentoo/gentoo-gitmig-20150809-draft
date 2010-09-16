# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.1.0-r1.ebuild,v 1.8 2010/09/16 17:13:03 scarabeus Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="1.4"

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

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Replace inclusion of malloc.h with stdlib.h as needed by Mac OS X and
	# FreeBSD. See bug #130340
	sed -i -e 's:malloc.h:stdlib.h:g' src/*

	# Don't build binary examples as they never get installed. See bug 141859
	sed -i -e 's:examples::' Makefile.am

	eautoreconf
}

src_compile() {
	econf --with-x --x-libraries=/usr/$(get_libdir)/opengl/xorg-x11 || die "econf failed"

	if use doc; then
		sed -i -e 's:\$(datadir)/doc/gle:\$(datadir)/doc/${PF}:' doc/Makefile
		sed -i -e 's:\$(datadir)/doc/gle/html:\$(datadir)/doc/${PF}/html:' doc/html/Makefile
	fi

	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	rm -rf "${D}"/usr/share/doc/gle
}

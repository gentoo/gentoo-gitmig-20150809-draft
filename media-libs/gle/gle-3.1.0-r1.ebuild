# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.1.0-r1.ebuild,v 1.11 2011/01/05 08:47:06 scarabeus Exp $

EAPI=3

inherit autotools multilib

DESCRIPTION="GL extrusion library"
HOMEPAGE="http://www.linas.org/gle"
SRC_URI="http://www.linas.org/gle/pub/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc static-libs"

DEPEND="virtual/opengl
	media-libs/freeglut
	app-admin/eselect-opengl"
RDEPEND="${DEPEND}"

src_prepare() {
	# Replace inclusion of malloc.h with stdlib.h as needed by Mac OS X and
	# FreeBSD. See bug #130340
	sed -i -e 's:malloc.h:stdlib.h:g' src/* || die

	# use proper docdir
	sed -i -e 's:\$(datadir)/doc/gle:\$(datadir)/doc/${PF}:' doc/Makefile.am || die
	sed -i -e 's:\$(datadir)/doc/gle/html:\$(datadir)/doc/${PF}/html:' doc/html/Makefile.am || die

	# Don't build binary examples as they never get installed. See bug 141859
	sed -i -e 's:examples::' Makefile.am || die

	epatch "${FILESDIR}"/${P}-autotools.patch

	eautoreconf
}

src_configure() {
	econf \
		--with-x \
		$(use_enable static-libs static) \
		--x-libraries=/usr/$(get_libdir)/opengl/xorg-x11
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README
}

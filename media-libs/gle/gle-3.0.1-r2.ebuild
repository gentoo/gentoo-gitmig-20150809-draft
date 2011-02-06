# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.0.1-r2.ebuild,v 1.36 2011/02/06 12:09:21 leio Exp $

EAPI=3

inherit autotools multilib

DESCRIPTION="GL extrusion library"
HOMEPAGE="http://www.linas.org/gle"
SRC_URI="http://www.linas.org/gle/pub/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86"
IUSE="doc static-libs"

DEPEND="virtual/opengl
	media-libs/freeglut
	app-admin/eselect-opengl"
RDEPEND="${DEPEND}"

src_prepare() {
	# Replace inclusion of malloc.h with stdlib.h as needed by Mac OS X and
	# FreeBSD. See bug #130340
	sed -i -e 's:malloc.h:stdlib.h:g' src/*

	# Don't build binary examples as they never get installed. See bug 141859
	sed -i -e 's:examples::' Makefile.am

	sed -i -e 's:SUFFIXES +=:SUFFIXES =:' man/Makefile.am public_html/Makefile.am
	sed -i -e 's:CLEANFILES +=:CLEANFILES =:' man/Makefile.am

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

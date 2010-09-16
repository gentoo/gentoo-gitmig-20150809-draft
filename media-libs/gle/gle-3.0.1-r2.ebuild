# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.0.1-r2.ebuild,v 1.32 2010/09/16 17:13:03 scarabeus Exp $

inherit eutils

DESCRIPTION="GL extrusion library"
HOMEPAGE="http://www.linas.org/gle"
SRC_URI="http://www.linas.org/gle/pub/gle-3.0.1.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/freeglut"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/configure-LANG.patch

	# Replace inclusion of malloc.h with stdlib.h as needed by Mac OS X and
	# FreeBSD.
	sed -i -e 's:malloc.h:stdlib.h:g' ${S}/src/*
}

src_compile() {
	econf --with-x || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
	dohtml -r public_html
}

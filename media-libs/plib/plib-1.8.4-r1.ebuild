# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/plib/plib-1.8.4-r1.ebuild,v 1.5 2007/08/13 21:07:56 dertobi123 Exp $

inherit flag-o-matic eutils

DESCRIPTION="multimedia library used by many games"
HOMEPAGE="http://plib.sourceforge.net/"
SRC_URI="http://plib.sourceforge.net/dist/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ppc ~sparc x86"
IUSE=""

DEPEND="virtual/glut
	virtual/opengl
	media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc41.patch
	epatch "${FILESDIR}"/${P}-too-many-axes.patch

	# Since plib only provides static libraries, force
	# building as PIC or plib is useless to amd64/etc...
	append-flags -fPIC
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog KNOWN_BUGS NOTICE README* TODO*
}

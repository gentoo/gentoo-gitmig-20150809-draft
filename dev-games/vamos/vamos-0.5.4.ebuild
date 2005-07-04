# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/vamos/vamos-0.5.4.ebuild,v 1.1 2005/07/04 07:32:57 vapier Exp $

inherit eutils

DESCRIPTION="an automotive simulation framework"
HOMEPAGE="http://vamos.sourceforge.net/"
SRC_URI="mirror://sourceforge/vamos/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/plib
	=dev-libs/libsigc++-1.2*
	media-libs/libpng
	virtual/x11
	virtual/opengl
	virtual/glu"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc.patch
	epatch "${FILESDIR}"/${P}-datadir.patch
}

src_install() {
	make install DESTDIR="${D}" || die "make install"
	dobin caelum/.libs/caelum || die "caelum"
	newdoc caelum/README README.caelum
	dodoc AUTHORS ChangeLog NEWS README TODO
}

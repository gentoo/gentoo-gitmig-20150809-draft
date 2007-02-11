# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/giblib/giblib-1.2.4.ebuild,v 1.8 2007/02/11 11:09:21 vapier Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Giblib, graphics library"
HOMEPAGE="http://www.linuxbrit.co.uk/giblib/"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

LICENSE="|| ( as-is BSD )"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ppc ppc64 sh sparc x86"
IUSE=""

DEPEND=">=media-libs/imlib2-1.0.3
	x11-libs/libX11
	x11-libs/libXext
	>=media-libs/freetype-2.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	built_with_use media-libs/imlib2 X || die "You need to re-emerge Imlib2 with USE=X"
	epunt_cxx
}

src_install() {
	emake DESTDIR="${D}" install || die
	rm -r "${D}"/usr/doc
	dodoc README AUTHORS ChangeLog TODO
}

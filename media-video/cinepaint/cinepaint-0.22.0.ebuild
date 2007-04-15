# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinepaint/cinepaint-0.22.0.ebuild,v 1.1 2007/04/15 14:13:11 aballier Exp $

inherit eutils versionator flag-o-matic

MY_PV=$(replace_version_separator 2 '-')
S=${WORKDIR}/${PN}-${MY_PV}
DESCRIPTION="motion picture editing tool used for painting and retouching of movies"
SRC_URI="mirror://sourceforge/cinepaint/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://cinepaint.sourceforge.net/"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
IUSE="png zlib"

DEPEND=">=x11-libs/gtk+-2.0
	png? ( >=media-libs/libpng-1.2 )
	zlib? ( sys-libs/zlib )
	media-libs/openexr
	>=media-libs/lcms-1.16
	media-libs/tiff
	media-libs/jpeg
	x11-libs/fltk"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-as-needed.patch"
}

src_compile(){
	# gutenprint is not in portage
	econf --disable-print --enable-gtk2 || die "econf failed"
	emake || die "emake failed"
}

src_install(){
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README NEWS
}

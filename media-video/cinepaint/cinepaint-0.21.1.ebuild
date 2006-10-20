# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinepaint/cinepaint-0.21.1.ebuild,v 1.1 2006/10/20 18:20:40 aballier Exp $

inherit eutils versionator flag-o-matic autotools

MY_PV=$(replace_version_separator 2 '-')
S=${WORKDIR}/${PN}-${MY_PV}
DESCRIPTION="motion picture editing tool used for painting and retouching of movies"
SRC_URI="mirror://sourceforge/cinepaint/${PN}-${MY_PV}.tar.gz
	mirror://gentoo/${P}-patches.tar.bz2"
HOMEPAGE="http://cinepaint.sourceforge.net/"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
LICENSE="GPL-2"
IUSE="png zlib"

DEPEND="=x11-libs/gtk+-1*
	png? ( >=media-libs/libpng-1.2 )
	zlib? ( sys-libs/zlib )
	media-libs/openexr
	media-libs/tiff
	media-libs/jpeg
	x11-libs/fltk"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}/${P}-as-needed.patch"
	epatch "${WORKDIR}/${P}-gcc4.patch"
}

src_compile(){
	[[ -f /usr/include/lcms/lcms.h ]] && \
		append-flags -I/usr/include/lcms

	# gutenprint is not in portage
	econf --disable-print || die "econf failed"
	emake || die "emake failed"
}

src_install(){
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS ChangeLog README* NEWS
}

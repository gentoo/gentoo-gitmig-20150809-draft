# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinepaint/cinepaint-0.19.0.ebuild,v 1.1 2005/03/18 20:06:07 chriswhite Exp $

inherit eutils versionator

MY_PV=$(replace_version_separator 2 '-')
S=${WORKDIR}/${PN}-${MY_PV}
DESCRIPTION="motion picture editing tool used for painting and retouching of movies"
SRC_URI="mirror://sourceforge/cinepaint/${PN}-${MY_PV}.tar.gz"
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
	media-libs/jpeg"

src_unpack() {
	unpack ${A}
	cd ${S}

	# lcms is <lcms/lcms.h> not <lcms.h>
	# fix that in configure detection
	# and in source
	epatch ${FILESDIR}/${PN}-lcms.patch
}

src_compile(){
	econf --with-openexr-prefix=/usr || die "econf failed"
	emake || die "emake failed"
}

src_install(){
	einstall DESTDIR=${D} || die "einstall failed"
	dodoc AUTHORS ChangeLog COPYING* README* NEWS
}

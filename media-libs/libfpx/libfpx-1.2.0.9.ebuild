# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfpx/libfpx-1.2.0.9.ebuild,v 1.2 2004/10/18 13:26:31 swegener Exp $

MY_PN=libfpx

### uncomment the right variables depending on if we have a patchlevel or not
#MY_P=${MY_PN}-${PV%.*}-${PV#*.*.*.}
#MY_P2=${MY_PN}-${PV%.*}
MY_P=${MY_PN}-${PV}
MY_P2=${MY_PN}-${PV}

S=${WORKDIR}/${MY_P2}
DESCRIPTION="A library for manipulating FlashPIX images"
SRC_URI="ftp://ftp.imagemagick.org/pub/ImageMagick/delegates/${MY_P}.tar.bz2"
HOMEPAGE=""

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_compile() {
	econf \
		--prefix=/usr \
		 || die

	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc doc/*
}

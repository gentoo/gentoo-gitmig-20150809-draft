# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfpx/libfpx-1.2.0.9.ebuild,v 1.5 2004/10/20 18:49:42 vapier Exp $

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

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
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

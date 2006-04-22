# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subtitleripper/subtitleripper-0.3.4-r1.ebuild,v 1.6 2006/04/22 10:54:54 corsair Exp $

inherit versionator

MY_PV="$(replace_version_separator 2 "-")"

DESCRIPTION="DVD Subtitle Ripper for Linux"
HOMEPAGE="http://subtitleripper.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tgz"
SLOT="0"
IUSE="zlib png"

DEPEND="media-libs/netpbm
		media-libs/libpng
		sys-libs/zlib
		png? ( >=media-libs/libpng-1.2.8 )
		zlib? ( >=sys-libs/zlib-1.2.3 )"

RDEPEND="${DEPEND}
	>=app-text/gocr-0.39"

S="${WORKDIR}/${PN}"

src_compile() {
	# PPM library is libnetppm
	sed -i -e "s:ppm:netpbm:g" Makefile
	if ! use zlib; then
		sed -i -e "s:DEFINES += -D_HAVE_ZLIB_:#DEFINES += -D_HAVE_ZLIB:g" Makefile
		sed -i -e "s:LIBS    += -lz:#LIBS     += -lz:g" Makefile
	fi
	if ! use png; then
		sed -i -e "s:DEFINES += -D_HAVE_PNG_:#DEFINES += -D_HAVE_PNG_:g" Makefile
		sed -i -e "s:LIBS    += -lpng:#LIBS     += -lpng:g" Makefile
	fi

	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe pgm2txt srttool subtitle2pgm subtitle2vobsub vobsub2pgm

	dodoc ChangeLog README*
}

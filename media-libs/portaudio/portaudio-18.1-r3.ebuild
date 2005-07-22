# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/portaudio/portaudio-18.1-r3.ebuild,v 1.2 2005/07/22 14:36:14 mr_bones_ Exp $

inherit toolchain-funcs

MY_P=${PN}_v${PV/./_}
DESCRIPTION="An open-source cross platform audio API."
HOMEPAGE="http://www.portaudio.com"
SRC_URI="http://www.portaudio.com/archives/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="18"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="app-arch/unzip"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	if use userland_Darwin ; then
		 cp ${FILESDIR}/${P}-Makefile.macos ${S}/Makefile
	else
		 cp ${FILESDIR}/${P}-Makefile.linux ${S}/Makefile
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" LD="$(tc-getLD)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR="${D}" libdir="/usr/$(get_libdir)" install || die
	dodoc docs/*
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/pablio/pablio-18.1.ebuild,v 1.3 2005/07/24 17:30:47 dholm Exp $

inherit toolchain-funcs

MY_P=portaudio_v${PV/./_}
DESCRIPTION="A blocking I/O library for portaudio."
HOMEPAGE="http://www.portaudio.com"
SRC_URI="http://www.portaudio.com/archives/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="18"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="=media-libs/portaudio-18*"
DEPEND="app-arch/unzip
	${RDEPEND}"

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
	dodoc portaudio/README.txt
}

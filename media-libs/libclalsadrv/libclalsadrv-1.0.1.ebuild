# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libclalsadrv/libclalsadrv-1.0.1.ebuild,v 1.5 2004/11/22 23:29:20 eradicator Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/clalsadrv-${PV}"

DESCRIPTION="An audio library by Fons Adriaensen <fons.adriaensen@skynet.be>"
HOMEPAGE="http://users.skynet.be/solaris/linuxaudio"
SRC_URI="http://users.skynet.be/solaris/linuxaudio/downloads/clalsadrv-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc x86"

DEPEND="virtual/libc
	>=media-libs/libclthreads-1.0.0
	media-libs/alsa-lib"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	epatch "${FILESDIR}/${P}-makefile.patch" || die
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS INSTALL
}

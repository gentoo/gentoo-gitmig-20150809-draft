# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox-cvs/dosbox-cvs-20030809.ebuild,v 1.1 2003/09/09 16:26:49 vapier Exp $

DESCRIPTION="DOS Emulator"
HOMEPAGE="http://www.dosbox.sf.net"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
IUSE="alsa"
SLOT="0"

# don't install this package and the stable one at the same time.
# they use the same binary names.
DEPEND="sys-libs/ncurses
	>=media-libs/libsdl-1.2.0
	media-libs/libpng
	sys-libs/zlib
	media-libs/sdl-net
	alsa? ( media-libs/alsa-lib )
	!app-emulation/dosbox"

inherit cvs debug flag-o-matic

strip-flags

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/dosbox"
ECVS_MODULE="dosbox"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	ln -s /usr/include/SDL/*.h ./include/ || \
		die "Linking SDL-includes failed"
	./autogen.sh --prefix=/usr --host=${CHOST} || \
		die "autogen.sh failed"
	econf `use_enable alsa alsatest` || die
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || \
		die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
}

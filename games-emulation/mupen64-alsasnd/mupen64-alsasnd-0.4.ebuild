# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header :$

inherit games eutils

DESCRIPTION="Alsa plugin for the mupen64 N64 emulator"
HOMEPAGE="http://www.emutalk.net/showthread.php?threadid=16895"
SRC_URI="alsa-plugin-${PV}fix.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="fetch"

DEPEND=">=media-libs/alsa-lib-0.9.0
	|| (
		gtk? ( =x11-libs/gtk+-1* )
		qt? ( >=x11-libs/qt-3 )
	)"

S=${WORKDIR}/alsa_plugin

pkg_nofetch() {
	einfo "Please visit this page to download the tarball:"
	einfo "http://www.emutalk.net/showpost.php?postid=170173&postcount=12"
	einfo "Then just put ${A} in ${DISTDIR} !"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo.patch
}

src_compile() {
	use qt && export GRAPHICAL_INTERFACE=qt3
	use gtk && export GRAPHICAL_INTERFACE=gtk1
	emake || die "make failed"
}

src_install() {
	exeinto ${GAMES_LIBDIR}/mupen64/plugins
	doexe mupen64_alsasnd-${PV}.so || die "doexe failed"
	dodoc README
}

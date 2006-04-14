# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-alsasnd/mupen64-alsasnd-0.4.ebuild,v 1.14 2006/04/14 04:06:37 halcy0n Exp $

inherit eutils games

DESCRIPTION="Alsa plugin for the mupen64 N64 emulator"
HOMEPAGE="http://www.emutalk.net/showthread.php?threadid=16895"
SRC_URI="mirror://gentoo/alsa-plugin-${PV}fix.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE="gtk qt"

DEPEND=">=media-libs/alsa-lib-0.9.0
	|| (
		gtk? ( =x11-libs/gtk+-2* )
		qt? ( =x11-libs/qt-3* )
		=x11-libs/gtk+-2*
	)"

S=${WORKDIR}/alsa_plugin

pkg_nofetch() {
	einfo "Please visit this page to download the tarball:"
	einfo "http://www.emutalk.net/showpost.php?postid=170173&postcount=12"
	einfo "Then just put ${A} in ${DISTDIR} !"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-gentoo.patch" \
		"${FILESDIR}/${PV}-gtk.patch" \
		"${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	export GRAPHICAL_INTERFACE=gtk2
	use qt && export GRAPHICAL_INTERFACE=qt3
	use gtk && export GRAPHICAL_INTERFACE=gtk2
	emake || die "make failed"
}

src_install() {
	exeinto "${GAMES_LIBDIR}/mupen64/plugins"
	doexe mupen64_alsasnd-${PV}.so || die "doexe failed"
	dodoc README
	prepgamesdirs
}

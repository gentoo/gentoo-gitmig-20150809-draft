# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox-cvs/dosbox-cvs-20030809.ebuild,v 1.10 2004/07/26 05:56:46 mr_bones_ Exp $

inherit games cvs

DESCRIPTION="DOS Emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"

KEYWORDS="x86 ppc ~amd64"
LICENSE="GPL-2"
IUSE="alsa opengl"
SLOT="0"

DEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )
	opengl? ( virtual/opengl )
	>=media-libs/libsdl-1.2.0
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-net"

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/dosbox"
ECVS_MODULE="dosbox"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S="${WORKDIR}/${ECVS_MODULE}"

src_compile() {
	local myconf=""

	if ! use alsa ; then
		myconf="--without-alsa-prefix --without-alsa-inc-prefix --disable-alsatest"
	fi
	./autogen.sh || die "autogen.sh failed"
	egamesconf \
		--disable-dependency-tracking \
		${myconf} \
		$(use_enable opengl) \
			|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "If you're using ati-drivers, you may need to use output=overlay"
	einfo "in the dosbox config file (see bug #57188)."
	echo
}

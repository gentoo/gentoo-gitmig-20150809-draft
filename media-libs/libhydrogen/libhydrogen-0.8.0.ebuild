# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libhydrogen/libhydrogen-0.8.0.ebuild,v 1.12 2004/07/14 20:09:35 agriffis Exp $

inherit libtool

DESCRIPTION="Linux Drum Machine - Libary"
HOMEPAGE="http://hydrogen.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/hydrogen/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="alsa"

RDEPEND="virtual/x11 \
	>=media-libs/audiofile-0.2.3 \
	alsa? ( media-libs/alsa-lib ) \
	media-sound/jack-audio-connection-kit"

DEPEND="$RDEPEND >=sys-devel/autoconf-2.58"

src_compile() {
	einfo "Reconfiguring..."
	export WANT_AUTOCONF=2.5
	aclocal
	autoconf
	automake

	elibtoolize
	sed -i "s/driver = new JackDriver(audioEngine_process);/driver = new JackDriver((JackProcessCallback) audioEngine_process);/" ${S}/src/Hydrogen.cpp

	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog FAQ README TODO
}

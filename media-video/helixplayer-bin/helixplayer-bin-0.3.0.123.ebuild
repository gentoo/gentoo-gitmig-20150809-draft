# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/helixplayer-bin/helixplayer-bin-0.3.0.123.ebuild,v 1.3 2004/07/14 21:44:04 agriffis Exp $

inherit nsplugins

DESCRIPTION="Helix Player (hxplay), the Helix Community open source media player"
HOMEPAGE="https://player.helixcommunity.org"
SRC_URI="https://helixcommunity.org/download.php/410/hxplay-${PV}-linux-2.2-libc6-gcc32-i586.tar.bz2"
LICENSE="realsdk"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="virtual/x11
		>=x11-libs/gtk+-2.2.0
		media-libs/libvorbis
		media-libs/libogg
		media-libs/faad2"

RESTRICT="nostrip"

src_unpack () {
	echo unpack noop
}

src_compile () {
	echo compile noop
}

src_install () {
	mkdir -p ${D}/opt/HelixPlayer
	cd ${D}/opt/HelixPlayer

	# Install the player
	tar xvjf ${DISTDIR}/${A}
	mkdir -p ${D}/usr/bin
	dosym /opt/HelixPlayer/hxplay /usr/bin/hxplay

	# Install the Mozilla plugin
	inst_plugin /opt/HelixPlayer/mozilla/nphelix.so
	inst_plugin /opt/HelixPlayer/mozilla/nphelix.xpt
}

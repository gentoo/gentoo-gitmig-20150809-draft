# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.8.3.ebuild,v 1.7 2007/08/30 17:00:11 drac Exp $

inherit eutils kde flag-o-matic

DESCRIPTION="Media player for KDE using xine and gstreamer backends."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="dvb xinerama vorbis encode kdehiddenvisibility"

RDEPEND=">=media-libs/xine-lib-1
	media-sound/cdparanoia
	encode? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	x11-libs/libXtst"

DEPEND="${RDEPEND}
	dvb? ( media-tv/linuxtv-dvb-headers )"

PATCHES="${FILESDIR}/${P}-build.patch"

need-kde 3.5.4

src_compile() {
	# see bug #143168
	replace-flags -O3 -O2

	local myconf="${myconf}
		$(use_with xinerama)
		$(use_with dvb)
		--without-gstreamer
		$(use_with vorbis oggvorbis)
		$(use_with encode lame)"

	kde_src_compile
}

src_install() {
	kde_src_install

	# Remove this, as kdelibs 3.5.4 provides it
	rm -f "${D}/usr/share/mimelnk/application/x-mplayer2.desktop"
}

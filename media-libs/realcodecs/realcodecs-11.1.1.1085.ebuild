# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/realcodecs/realcodecs-11.1.1.1085.ebuild,v 1.1 2008/10/07 15:02:53 beandog Exp $

inherit eutils

MY_PN="RealPlayer"
DESCRIPTION="Real Media Player 32-bit binary codecs"
HOMEPAGE="http://www.real.com/ http://player.helixcommunity.org/"
SRC_URI="http://forms.helixcommunity.org/helix/builds/index.html?filename=20081006/player_all-realplay_gtk_current-20081006-linux-2.2-libc6-gcc32-i586/realplay-11.1.1.1085-linux-2.2-libc6-gcc32-i586.tar.bz2"
RESTRICT="mirror strip test fetch"
LICENSE="HBRL"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
DEPEND="!<=media-video/realplayer-11.0.0.4028-r1"
RDEPEND="!amd64? ( =virtual/libstdc++-3.3* )
		amd64? ( app-emulation/emul-linux-x86-compat )"

QA_TEXTRELS="codecs/raac.so
	codecs/colorcvt.so
	codecs/drv2.so
	codecs/drvc.so"

QA_EXECSTACK="codecs/raac.so
	codecs/drvc.so
	codecs/drv2.so
	codecs/colorcvt.so
	codecs/atrc.so"

S="${WORKDIR}"

pkg_nofetch() {
	einfo "Download RealPlayer manually from Real's website at"
	einfo ${SRC_URI}
	einfo ""
	einfo "If you accept the license, then put the .tar.bz2 file"
	einfo "into ${DISTDIR} and restart the emerge."
}

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

src_install() {
	fperms 644 codecs/*
	insinto "/opt/RealPlayer/codecs"
	doins codecs/*

	cd "${S}"
}

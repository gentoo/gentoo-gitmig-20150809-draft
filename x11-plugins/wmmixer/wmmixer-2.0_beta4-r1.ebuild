# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmixer/wmmixer-2.0_beta4-r1.ebuild,v 1.4 2007/01/25 16:11:30 s4t4n Exp $

inherit eutils

IUSE="alsa"

DESCRIPTION="The next generation of WMMixer with native ALSA and OSS support."
SRC_URI="http://freakzone.net/gordon/src/${PN}-2.0b4.tar.gz"
HOMEPAGE="http://freakzone.net/gordon/#wmmixer"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~mips sparc x86"

S="${WORKDIR}/${PN}-2.0b4"

src_unpack() {

	unpack ${A}
	cd ${S}
	sed -i 's#/usr/local/share#/usr/share#g' src/wmmixer.h example/*

	# Allow use of Gentoo CXXFLAGS
	epatch ${FILESDIR}/${PN}-cflags.patch

	# Fix compilation issues with recent gcc versions
	epatch ${FILESDIR}/${P}.gcc.patch
}

src_compile() {

	local myconf=""

	if use alsa ; then
		myconf="${myconf} --enable-alsa"
	fi

	econf "${myconf}" || die
	emake || die
}

src_install() {

	einstall || die
	dodoc README AUTHORS example/home.wmmixerrc example/home.wmmixer

	einfo
	einfo "Two sample configuration files have been installed in /usr/share/doc/${PF}/."
	einfo "You can copy one of them to ~/.wmmixerrc and adjust any settings you may need."
	einfo
}

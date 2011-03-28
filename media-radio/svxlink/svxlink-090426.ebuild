# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/svxlink/svxlink-090426.ebuild,v 1.6 2011/03/28 08:55:17 ssuominen Exp $

EAPI=2
inherit eutils multilib

DESCRIPTION="Multi Purpose Voice Services System, including Qtel for EchoLink"
HOMEPAGE="http://svxlink.sourceforge.net/"
SRC_URI="mirror://sourceforge/svxlink/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="dev-lang/tcl
	media-sound/gsm
	dev-libs/libgcrypt
	media-libs/speex
	dev-libs/libsigc++:1.2
	dev-libs/popt"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-080730--as-needed.patch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-noqt.patch

	sed -i -e "s:/lib:/$(get_libdir):g" makefile.cfg || die
	sed -i -e "s:/etc/udev:/lib/udev:" svxlink/scripts/Makefile.default || die
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
}

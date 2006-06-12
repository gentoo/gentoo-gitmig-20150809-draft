# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-kde/xmms-kde-3.1.ebuild,v 1.8 2006/06/12 00:08:12 metalgod Exp $

ARTS_REQUIRED="yes"

inherit kde eutils

DESCRIPTION="MP3 player integrated into the KDE panel (can control XMMS and Noatun too)"
HOMEPAGE="http://xmms-kde.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmms-kde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="xmms sdl"

DEPEND="xmms? ( >=media-sound/xmms-1.2.7-r23 )
	sdl? ( >=media-libs/smpeg-0.4.4-r4 )"

need-kde 3.1

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}"/${P}-gcc4.patch
}

src_compile() {
	myconf="--disable-gtk-test"
	kde_src_compile
}

src_install() {
	kde_src_install
	dodoc MISSING VERSION
}

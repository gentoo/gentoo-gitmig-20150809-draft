# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lxmusic/lxmusic-0.4.4.ebuild,v 1.4 2011/01/29 20:20:12 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="A simple GUI XMMS2 client with minimal functionality"
HOMEPAGE="http://lxde.sourceforge.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	media-sound/xmms2
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README
}

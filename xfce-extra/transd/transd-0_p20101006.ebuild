# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/transd/transd-0_p20101006.ebuild,v 1.7 2011/03/29 04:05:38 ssuominen Exp $

EAPI=3
EAUTORECONF=yes
EINTLTOOLIZE=yes
inherit xfconf

DESCRIPTION="A small daemon to watch for window creation and set window transparency values"
HOMEPAGE="http://spuriousinterrupt.org/projects/transd"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND="x11-libs/libX11
	>=xfce-base/libxfcegui4-4.2"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)
	DOCS="AUTHORS README TODO"
}

src_prepare() {
	sed -i -e '/Encoding/d' transd.desktop.in || die
	xfconf_src_prepare
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/transd/transd-0_p20120503.ebuild,v 1.2 2012/05/04 07:42:09 ssuominen Exp $

EAPI=4
EAUTORECONF=yes
EINTLTOOLIZE=yes
inherit xfconf

DESCRIPTION="A small daemon to watch for window creation and set window transparency values"
HOMEPAGE="http://spuriousinterrupt.org/projects/transd"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	>=xfce-base/libxfce4util-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS README TODO )
}

src_prepare() {
	sed -i -e '/Encoding/d' transd.desktop.in || die
	xfconf_src_prepare
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxpanel/lxpanel-0.4.1.ebuild,v 1.1 2009/05/24 22:55:07 yngwin Exp $

EAPI="2"
inherit eutils

DESCRIPTION="Lightweight X11 desktop panel for LXDE"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+X +alsa wifi"
RESTRICT="test"  # bug 249598

RDEPEND="x11-libs/gtk+:2
	x11-libs/libXmu
	x11-libs/libXpm
	lxde-base/lxmenu-data
	lxde-base/menu-cache
	alsa? ( media-libs/alsa-lib )
	wifi? ( net-wireless/wireless-tools )
	X? ( x11-libs/libX11 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf $(use_enable alsa) \
		$(use_enable wifi libiw) \
		$(use_with X x) \
		--with-plugins=all
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}

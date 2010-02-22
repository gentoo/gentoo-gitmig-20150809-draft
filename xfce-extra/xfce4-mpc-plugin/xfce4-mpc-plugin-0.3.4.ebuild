# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mpc-plugin/xfce4-mpc-plugin-0.3.4.ebuild,v 1.3 2010/02/22 18:40:55 fauli Exp $

inherit xfconf

DESCRIPTION="Music Player Daemon (mpd) panel plugin"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.3/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
IUSE="debug libmpd"

RDEPEND=">=xfce-base/xfce4-panel-4.3.22
	libmpd? ( media-libs/libmpd )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	dev-perl/XML-Parser"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)
		$(use_enable libmpd)"
	DOCS="AUTHORS ChangeLog README TODO"
}

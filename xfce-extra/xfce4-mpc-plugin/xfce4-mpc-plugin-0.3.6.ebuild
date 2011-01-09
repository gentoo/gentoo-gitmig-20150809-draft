# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mpc-plugin/xfce4-mpc-plugin-0.3.6.ebuild,v 1.1 2011/01/09 11:36:03 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Music Player Daemon (mpd) panel plugin"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-mpc-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.3/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug libmpd"

RDEPEND=">=xfce-base/exo-0.3.1.1
	>=xfce-base/libxfcegui4-4.3.22
	>=xfce-base/xfce4-panel-4.3.22
	libmpd? ( media-libs/libmpd )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(use_enable libmpd)
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog README TODO"
}

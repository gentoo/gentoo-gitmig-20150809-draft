# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mpc-plugin/xfce4-mpc-plugin-0.3.6.ebuild,v 1.6 2012/05/05 07:17:18 mgorny Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Music Player Daemon (mpd) panel plugin"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-mpc-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.3/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="libmpd"

RDEPEND=">=xfce-base/exo-0.6
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8
	libmpd? ( media-libs/libmpd )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool"

pkg_setup() {
	XFCONF=( $(use_enable libmpd) )
	DOCS=( AUTHORS ChangeLog README TODO )
}

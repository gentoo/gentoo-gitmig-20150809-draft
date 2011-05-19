# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xfmpc/xfmpc-0.2.1.ebuild,v 1.5 2011/05/19 22:21:27 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Music Player Daemon (MPD) client for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfmpc"
SRC_URI="mirror://xfce/src/apps/${PN}/0.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.18:2
	>=media-libs/libmpd-0.15
	>=x11-libs/gtk+-2.14:2
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=( $(xfconf_use_debug) )
	DOCS=( AUTHORS ChangeLog IDEAS NEWS README THANKS )
}

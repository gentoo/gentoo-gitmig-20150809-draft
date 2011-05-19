# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-modemlights-plugin/xfce4-modemlights-plugin-0.1.3.99.ebuild,v 1.5 2011/05/19 21:00:00 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A panel plug-in intended to simplify establishing a ppp connection"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-modemlights-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.8:2
	>=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=( $(use_enable debug) )
	DOCS=( AUTHORS ChangeLog NEWS README )
}

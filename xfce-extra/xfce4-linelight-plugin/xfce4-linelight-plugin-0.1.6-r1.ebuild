# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-linelight-plugin/xfce4-linelight-plugin-0.1.6-r1.ebuild,v 1.7 2012/05/05 07:15:58 mgorny Exp $

EAPI=4
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="A simple locate based search plug-in for the Xfce panel"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-linelight-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND=">=xfce-base/xfce4-panel-4.8
	=xfce-base/libxfcegui4-4.8*
	=xfce-base/libxfce4util-4.8*
	>=x11-libs/gtk+-2.12:2
	>=dev-libs/glib-2.18:2"
RDEPEND="${COMMON_DEPEND}
	sys-apps/mlocate"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	PATCHES=(
		"${FILESDIR}"/${P}-libxfce4panel_h.patch
		"${FILESDIR}"/${P}-port-to-gio.patch
		)

	DOCS=( AUTHORS ChangeLog NEWS )
}

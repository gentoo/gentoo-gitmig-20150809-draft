# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-cpufreq-plugin/xfce4-cpufreq-plugin-1.0.0.ebuild,v 1.2 2011/03/13 16:28:14 hwoarang Exp $

EAPI=3
inherit xfconf

DESCRIPTION="A panel plugin for showing information about cpufreq settings"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-cpufreq-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-4.3.90
	>=xfce-base/libxfcegui4-4.3.90
	>=xfce-base/xfce4-panel-4.3.90"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		)

	DOCS="AUTHORS ChangeLog NEWS README"
}

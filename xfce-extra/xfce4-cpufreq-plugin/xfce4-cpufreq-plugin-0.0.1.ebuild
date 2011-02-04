# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-cpufreq-plugin/xfce4-cpufreq-plugin-0.0.1.ebuild,v 1.3 2011/02/04 17:59:43 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="A panel plugin for showing information about cpufreq settings"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.0/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-4.3.90
	>=xfce-base/libxfcegui4-4.3.90
	>=xfce-base/xfce4-panel-4.3.90"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool"

S=${WORKDIR}/${P/cpuf/cpu-f}

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(use_enable debug)
		)
	DOCS="AUTHORS ChangeLog README"
}

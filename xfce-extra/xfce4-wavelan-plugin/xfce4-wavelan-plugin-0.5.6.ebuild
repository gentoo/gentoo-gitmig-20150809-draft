# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-wavelan-plugin/xfce4-wavelan-plugin-0.5.6.ebuild,v 1.8 2012/05/05 07:47:44 mgorny Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Wireless monitor panel plugin"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-wavelan-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.5/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ppc ppc64 x86"
IUSE=""

RDEPEND=">=xfce-base/xfce4-panel-4.8
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/libxfce4util-4.8
	>=x11-libs/gtk+-2.6:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS ChangeLog NEWS README THANKS )
}

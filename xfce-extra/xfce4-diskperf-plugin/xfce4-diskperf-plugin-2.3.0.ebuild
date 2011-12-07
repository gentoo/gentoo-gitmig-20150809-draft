# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-diskperf-plugin/xfce4-diskperf-plugin-2.3.0.ebuild,v 1.9 2011/12/07 15:43:53 ssuominen Exp $

EAPI=4
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Xfce's disk usage and performance panel plugin"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-diskperf-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/2.3/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND=">=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-underlinking.patch )
	DOCS=( AUTHORS ChangeLog NEWS README )
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-genmon-plugin/xfce4-genmon-plugin-3.3.1.ebuild,v 1.1 2012/01/02 15:18:54 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Cyclically spawns the executable, captures its output and displays the result into the panel."
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-genmon-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND=">=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS ChangeLog NEWS README )
}

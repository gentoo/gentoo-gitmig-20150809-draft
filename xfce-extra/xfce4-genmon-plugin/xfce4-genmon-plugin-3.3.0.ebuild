# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-genmon-plugin/xfce4-genmon-plugin-3.3.0.ebuild,v 1.1 2011/03/22 15:16:33 angelos Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Cyclically spawns the executable, captures its output and displays the result into the panel."
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/3.3/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=xfce-base/libxfcegui4-4.3.22
	>=xfce-base/xfce4-panel-4.3.22"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog NEWS README"
}

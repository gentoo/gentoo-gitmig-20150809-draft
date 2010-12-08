# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-netload-plugin/xfce4-netload-plugin-1.0.0.ebuild,v 1.2 2010/12/08 14:46:44 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Xfce's netload panel plug-in"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=xfce-base/libxfcegui4-4.4.0
	>=xfce-base/xfce4-panel-4.3.20"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog README"
}

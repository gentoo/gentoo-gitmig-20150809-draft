# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mount-plugin/xfce4-mount-plugin-0.5.5.ebuild,v 1.3 2011/01/29 21:00:15 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Mount plugin for the Xfce panel"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.5/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=xfce-base/libxfcegui4-4.3.20
	>=xfce-base/xfce4-panel-4.3.20"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(use_enable debug)
		)

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

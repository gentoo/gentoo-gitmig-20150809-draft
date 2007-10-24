# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/compiz-fusion/compiz-fusion-0.6.0.ebuild,v 1.2 2007/10/24 18:07:56 lu_zero Exp $

DESCRIPTION="Compiz Fusion meta package"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="gnome kde"

DEPEND=">=x11-plugins/compiz-fusion-plugins-main-${PV}
	>=x11-plugins/compiz-fusion-plugins-extra-${PV}
	>=x11-themes/emerald-themes-0.5.2
	>=x11-apps/ccsm-${PV}
	gnome? ( >=x11-libs/compizconfig-backend-gconf-${PV} )
	kde? ( >=x11-libs/compizconfig-backend-kconfig-${PV} )"

pkg_postinst() {
	einfo "Upstream provides an unsupported-package, which is not part of this meta ebuild."
	einfo "To install it \"emerge compiz-fusion-plugins-unsupported\"."
}

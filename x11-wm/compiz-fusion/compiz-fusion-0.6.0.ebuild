# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/compiz-fusion/compiz-fusion-0.6.0.ebuild,v 1.5 2009/10/23 09:04:28 ssuominen Exp $

DESCRIPTION="Compiz Fusion meta package"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnome"

RDEPEND=">=x11-plugins/compiz-fusion-plugins-main-${PV}
	>=x11-plugins/compiz-fusion-plugins-extra-${PV}
	>=x11-themes/emerald-themes-0.5.2
	>=x11-apps/ccsm-${PV}
	gnome? ( >=x11-libs/compizconfig-backend-gconf-${PV} )"
DEPEND="${RDEPEND}"

pkg_postinst() {
	einfo "Upstream provides an unsupported-package, which is not part of this meta ebuild."
	einfo "To install it \"emerge compiz-fusion-plugins-unsupported\"."
}

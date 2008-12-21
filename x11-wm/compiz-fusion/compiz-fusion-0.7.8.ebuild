# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/compiz-fusion/compiz-fusion-0.7.8.ebuild,v 1.2 2008/12/21 18:50:14 jmbsvicetto Exp $

DESCRIPTION="Compiz Fusion (meta)"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emerald gnome kde unsupported"

RDEPEND="~x11-wm/compiz-${PV}
	~x11-plugins/compiz-fusion-plugins-main-${PV}
	~x11-plugins/compiz-fusion-plugins-extra-${PV}
	unsupported? ( ~x11-plugins/compiz-fusion-plugins-unsupported-${PV} )
	~x11-apps/ccsm-${PV}
	emerald? ( ~x11-wm/emerald-${PV} )
	gnome? ( ~x11-libs/compizconfig-backend-gconf-${PV} )
	kde? ( ~x11-libs/compizconfig-backend-kconfig-${PV} )"

pkg_postinst() {
	ewarn "If you want to try out simple-ccsm, you'll need to emerge it"
	ewarn "If you want to use emerald, set the emerald use flag"
}

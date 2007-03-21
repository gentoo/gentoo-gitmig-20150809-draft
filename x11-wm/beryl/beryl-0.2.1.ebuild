# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/beryl/beryl-0.2.1.ebuild,v 1.1 2007/03/21 03:14:09 tsunam Exp $

inherit eutils

DESCRIPTION="Beryl window manager for AiGLX and XGL (meta)"
HOMEPAGE="http://beryl-project.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="kde gnome noemerald"

RDEPEND="~x11-wm/beryl-core-${PV}
	~x11-plugins/beryl-plugins-${PV}
	!noemerald? ( ~x11-wm/emerald-${PV} )
	kde? ( ~x11-wm/aquamarine-${PV} )
	gnome? ( ~x11-wm/heliodor-${PV} )
	~x11-misc/beryl-settings-${PV}
	~x11-misc/beryl-manager-${PV}
	>=x11-libs/cairo-1.2"

pkg_setup() {
	if use noemerald && ! use kde && ! use gnome; then
		echo
		elog "You have not selected any window decorator. For the meta"
		elog "install, you should choose at least one of either emerald,"
		elog "kde (aquamarine) or gnome (heliodor) decorators. Although"
		elog "you may proceed without, you will have no window decorations"
		elog "unless you enable emerald, kde, or gnome (unless provided"
		elog "externally via another package)."
		echo
		elog "To enable the default window decorator, please disable the"
		elog "noemerald use flag. Alternatively, set use kde or gnome for"
		elog "aquamarine and/or heliodor, respectively."
		echo
	fi
}

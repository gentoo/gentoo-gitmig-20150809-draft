# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-cornerxmms/desklet-cornerxmms-0.1.0.ebuild,v 1.3 2006/03/24 21:04:49 agriffis Exp $

inherit gdesklets

DESKLET_NAME="CornerXMMS"

MY_P="${DESKLET_NAME}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A desklet for controlling XMMS"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=287"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~ia64 ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.35
	>=dev-python/pyxmms-2.06"

DOCS="Changelog README TODO"

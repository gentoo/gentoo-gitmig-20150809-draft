# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-calendar/desklet-calendar-0.21.ebuild,v 1.3 2006/10/06 12:56:17 nixnut Exp $

inherit gdesklets

DESKLET_NAME="Calendar"

MY_PN="${DESKLET_NAME}"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_PN}

DESCRIPTION="A calendar display for gDesklets"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=213"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~alpha ~ppc ~x86"
RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

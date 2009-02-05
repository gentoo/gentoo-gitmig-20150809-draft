# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-calendar/desklet-calendar-0.21.ebuild,v 1.4 2009/02/05 05:49:46 darkside Exp $

inherit gdesklets

DESKLET_NAME="Calendar"

MY_PN="${DESKLET_NAME}"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_PN}

DESCRIPTION="A calendar display for gDesklets"
HOMEPAGE="http://gdesklets.de/index.php?q=desklet/view/121"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~alpha ~ppc ~x86"
RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

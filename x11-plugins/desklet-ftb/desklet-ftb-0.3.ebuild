# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-ftb/desklet-ftb-0.3.ebuild,v 1.2 2005/07/31 11:26:46 dholm Exp $

inherit gdesklets

DESKLET_NAME="FTB"

MY_P="${DESKLET_NAME}-${PV}"
S=${WORKDIR}/Displays/${DESKLET_NAME}

DESCRIPTION="Configurable, stackable system monitors"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=224"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~ppc ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

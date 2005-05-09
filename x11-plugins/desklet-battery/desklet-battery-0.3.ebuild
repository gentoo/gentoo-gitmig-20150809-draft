# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-battery/desklet-battery-0.3.ebuild,v 1.2 2005/05/09 18:40:53 dholm Exp $

inherit gdesklets

DESKLET_NAME="Battery"
SENSOR_NAME="${DESKLET_NAME}"

MY_PN=${PN/desklet-/}-gdesklet
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A battery monitoring sensor and display for gDesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=47"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

DOCS="INSTALL README"

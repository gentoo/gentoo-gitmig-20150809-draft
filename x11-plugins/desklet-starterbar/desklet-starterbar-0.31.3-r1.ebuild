# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-starterbar/desklet-starterbar-0.31.3-r1.ebuild,v 1.1 2005/07/07 01:35:22 nixphoeni Exp $

inherit gdesklets

DESKLET_NAME="StarterBar"
SENSOR_NAME="StarterBar"

MY_PN=${PN/desklet-/}-desklet
MY_P=${MY_PN}-${PV}

S=${WORKDIR}/${MY_P}

DESCRIPTION="An OSX-like gnome panel for launchers"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=13"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3
	>=gnome-base/gnome-panel-2.10.0-r1"

DOCS="README"


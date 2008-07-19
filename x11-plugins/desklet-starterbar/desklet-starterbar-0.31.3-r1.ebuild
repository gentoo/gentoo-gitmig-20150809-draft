# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-starterbar/desklet-starterbar-0.31.3-r1.ebuild,v 1.9 2008/07/19 18:46:47 leio Exp $

inherit gdesklets

DESKLET_NAME="StarterBar"
SENSOR_NAME="StarterBar"

MY_PN=${PN/desklet-/}-desklet
MY_P=${MY_PN}-${PV}

S=${WORKDIR}/${MY_P}

DESCRIPTION="An OSX-like gnome panel for launchers"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://gdesklets.zencomputer.ca/"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~alpha amd64 ~ia64 ppc ~sparc x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3
	>=gnome-base/gnome-panel-2.10.0-r1"

DOCS="README"

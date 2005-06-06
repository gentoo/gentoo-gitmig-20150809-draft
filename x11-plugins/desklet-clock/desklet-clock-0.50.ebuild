# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-clock/desklet-clock-0.50.ebuild,v 1.1 2005/06/06 02:44:29 nixphoeni Exp $

inherit gdesklets

DESKLET_NAME="Clock"
MY_PN="${PN/desklet-/}-desklet"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Clock displays for gDesklets"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=12"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
LICENSE="GPL-2"

RDEPEND=">=gnome-extra/gdesklets-core-0.35"

DOCS="README"

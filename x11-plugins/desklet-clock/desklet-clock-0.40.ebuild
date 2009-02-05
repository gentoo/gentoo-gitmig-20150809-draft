# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-clock/desklet-clock-0.40.ebuild,v 1.3 2009/02/05 05:53:49 darkside Exp $

inherit gdesklets

DESKLET_NAME="Clock"
MY_PN="${PN/desklet-/}-desklet"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Clock displays for gDesklets"
HOMEPAGE="http://gdesklets.de/index.php?q=desklet/view/201"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

DOCS="README"

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-sidecandy/desklet-sidecandy-0.10.ebuild,v 1.3 2005/06/29 19:28:10 gustavoz Exp $

inherit gdesklets

DESKLET_NAME="SideCandy"

MY_P="${DESKLET_NAME}-${PV}"
S=${WORKDIR}/${DESKLET_NAME}

DESCRIPTION="A template and collection of displays for gDesklets"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=212"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

DOCS="README"

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-scweather/desklet-scweather-0.4.ebuild,v 1.4 2006/04/30 04:17:47 tcort Exp $

inherit gdesklets

DESKLET_NAME="SC-Weather"

MY_P="${DESKLET_NAME}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A weather display using SideCandy for gDesklets"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=244"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

DOCS="README"

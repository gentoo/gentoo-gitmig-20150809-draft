# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-rsstickerbar/desklet-rsstickerbar-0.15.ebuild,v 1.3 2006/10/06 13:52:14 nixnut Exp $

inherit gdesklets

DESKLET_NAME="RSSTicker"

MY_P="${DESKLET_NAME/RSST/rsst}-${PV}"
S=${WORKDIR}/${DESKLET_NAME}

DESCRIPTION="A highly configurable RSS ticker for your desktop"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=269"
#SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.bz2"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~alpha ~ia64 ppc ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.35"

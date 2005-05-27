# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-rsstickerbar/desklet-rsstickerbar-0.12.ebuild,v 1.1 2005/05/27 11:48:06 nixphoeni Exp $

inherit gdesklets

DESKLET_NAME="RSSTicker"

MY_P="${DESKLET_NAME/RSST/rsst}"
S=${WORKDIR}/${DESKLET_NAME}

DESCRIPTION="A highly configurable RSS ticker"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=269"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc"

RDEPEND=">=gnome-extra/gdesklets-core-0.35"

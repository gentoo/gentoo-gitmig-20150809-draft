# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-justanicon/desklet-justanicon-0.2.ebuild,v 1.1 2005/08/30 20:04:57 nixphoeni Exp $

inherit gdesklets

DESKLET_NAME="JustAnIcon"

MY_P="${DESKLET_NAME}-${PV}"
S=${WORKDIR}/Displays/${DESKLET_NAME}

DESCRIPTION="A configurable desktop icon"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=281"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

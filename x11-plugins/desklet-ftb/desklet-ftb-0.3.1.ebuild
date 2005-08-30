# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-ftb/desklet-ftb-0.3.1.ebuild,v 1.1 2005/08/30 20:44:11 nixphoeni Exp $

inherit gdesklets

DESKLET_NAME="FTB"

MY_P="${DESKLET_NAME}-${PV/%.1/,1}" # Replace the last period in the file name with a comma
S=${WORKDIR}/Displays/${DESKLET_NAME}

DESCRIPTION="Configurable, stackable system monitors"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=224"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~ppc ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

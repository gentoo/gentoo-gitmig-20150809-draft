# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-wirelessmonitor/desklet-wirelessmonitor-0.13.ebuild,v 1.5 2009/02/05 05:46:30 darkside Exp $

inherit gdesklets

DESKLET_NAME="WirelessMon"

MY_P="${DESKLET_NAME}-${PV}"
S=${WORKDIR}/${DESKLET_NAME}

DESCRIPTION="A wireless signal strength display for gDesklets"
HOMEPAGE="http://gdesklets.de/index.php?q=desklet/view/81"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3
	net-wireless/wireless-tools"

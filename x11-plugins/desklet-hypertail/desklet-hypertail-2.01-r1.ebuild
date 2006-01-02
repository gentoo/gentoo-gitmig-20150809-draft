# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-hypertail/desklet-hypertail-2.01-r1.ebuild,v 1.4 2006/01/02 18:36:37 metalgod Exp $

inherit gdesklets

DESKLET_NAME="HyperTail"
MY_PN=${PN/desklet-/}
S=${WORKDIR}/${MY_PN}

DESCRIPTION="A log file monitor for gDesklets"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=215"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_PN}-${PV}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc x86"
LICENSE="GPL-2"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3
	 >=x11-plugins/desklet-regexp-1.0"

DOCS="README firewall.sh syslog-ng.conf"

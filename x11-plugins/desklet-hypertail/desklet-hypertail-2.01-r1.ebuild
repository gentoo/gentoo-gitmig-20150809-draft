# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-hypertail/desklet-hypertail-2.01-r1.ebuild,v 1.5 2006/01/17 13:12:24 nixphoeni Exp $

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

RDEPEND="<gnome-extra/gdesklets-core-0.35_rc1
	 >=x11-plugins/desklet-regexp-1.0"

DOCS="README firewall.sh syslog-ng.conf"

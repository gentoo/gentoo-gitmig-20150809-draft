# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-hypertail/desklet-hypertail-2.01-r1.ebuild,v 1.6 2006/04/30 04:09:22 tcort Exp $

inherit gdesklets

DESKLET_NAME="HyperTail"
MY_PN=${PN/desklet-/}
S=${WORKDIR}/${MY_PN}

DESCRIPTION="A log file monitor for gDesklets"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=215"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_PN}-${PV}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~ppc x86"
LICENSE="GPL-2"

RDEPEND="<gnome-extra/gdesklets-core-0.35_rc1
	 >=x11-plugins/desklet-regexp-1.0"

DOCS="README firewall.sh syslog-ng.conf"

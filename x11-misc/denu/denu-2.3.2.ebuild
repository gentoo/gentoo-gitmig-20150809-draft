# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/denu/denu-2.3.2.ebuild,v 1.1 2005/03/19 20:26:21 blubb Exp $

DESCRIPTION="A menu generation program for fluxbox, waimea, openbox, icewm, gnome and
kde."
HOMEPAGE="http://denu.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/python
	>=sys-apps/portage-2.0.50-r10
	>=dev-python/pygtk-2.4.1"

RDEPEND=${DEPEND}

src_install() {
	cd ${WORKDIR}/${P}
	sh install.sh ${D}
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ng-spice-rework/ng-spice-rework-15.ebuild,v 1.5 2004/09/13 20:58:56 plasmaroo Exp $

DESCRIPTION="NGSpice - The Next Generation Spice (Circuit Emulator)"
SRC_URI="http://www.geda.seul.org/dist/ngspice-rework${PV}.tgz"
HOMEPAGE="http://ngspice.sourceforge.net"

SLOT="0"
IUSE=""
LICENSE="BSD GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	local infoFile
	for infoFile in doc/ngspice.info*; do
		echo 'INFO-DIR-SECTION EDA' >> ${infoFile}
		echo 'START-INFO-DIR-ENTRY' >> ${infoFile}
		echo '* NGSPICE: (ngspice). Electronic Circuit Simulator.' >> ${infoFile}
		echo 'END-INFO-DIR-ENTRY' >> ${infoFile}
	done

	make DESTDIR=${D} install || die
	dodoc COPYING COPYRIGHT CREDITS ChangeLog README
}

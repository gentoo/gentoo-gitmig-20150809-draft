# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/foldingathome/foldingathome-3.14.ebuild,v 1.4 2003/07/02 12:33:39 aliz Exp $

# no version number on this install dir since upgrades will be using same dir
# (data will be stored here too)
I="/opt/foldingathome"

DESCRIPTION="Help simulate protein folding at home"
HOMEPAGE="http://folding.stanford.edu/"
SRC_URI="http://www.stanford.edu/group/pandegroup/release/FAH3Console-Linux.exe"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

DEPEND=">=sys-apps/baselayout-1.8.0"
S="${WORKDIR}/${P}"

src_unpack() {
	mkdir ${P}
	cp ${DISTDIR}/FAH3Console-Linux.exe ${P}
}

src_install() {
	exeinto ${I} ; newexe FAH3Console-Linux.exe foldingathome
	exeinto /etc/init.d ; newexe ${FILESDIR}/folding-init.d foldingathome
}

pkg_postinst() {
	einfo "To run Folding@home in the background at boot:"
	einfo " rc-update add foldingathome default"
	einfo ""
}

pkg_postrm() {
	einfo "Folding@home data files were not removed."
	einfo " Remove them manually from ${I}"
	einfo ""
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/foldingathome/foldingathome-3.24.ebuild,v 1.2 2003/04/23 08:20:25 aliz Exp $

# no version number on this install dir since upgrades will be using same dir
# (data will be stored here too)
I="/opt/foldingathome"

DESCRIPTION="Help simulate protein folding at home"
HOMEPAGE="http://folding.stanford.edu/"
SRC_URI="http://www.stanford.edu/group/pandegroup/release/FAH3Console-v${PV/.}-LinuxB.exe
	http://www.stanford.edu/group/pandegroup/release/FAH3Console-v${PV/.}-Linux.exe"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

DEPEND=">=sys-apps/baselayout-1.8.0"
S="${WORKDIR}/${P}"

src_unpack() {
	mkdir -p ${S} ; cd ${S}
	if has_version \>=glibc-2.3.0; then
		cp ${DISTDIR}/FAH3Console-v${PV/.}-LinuxB.exe ${PN}
	else
		cp ${DISTDIR}/FAH3Console-v${PV/.}-Linux.exe ${PN}
	fi
}

src_install() {
	exeinto ${I} ; doexe foldingathome
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

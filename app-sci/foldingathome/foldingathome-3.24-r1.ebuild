# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/foldingathome/foldingathome-3.24-r1.ebuild,v 1.2 2004/03/26 12:13:49 phosphan Exp $

# no version number on this install dir since upgrades will be using same dir
# (data will be stored here too)
I="/opt/foldingathome"

inherit eutils

DESCRIPTION="Help simulate protein folding at home"
HOMEPAGE="http://folding.stanford.edu/"
SRC_URI="http://www.stanford.edu/group/pandegroup/release/FAH3Console-v${PV/.}-LinuxB.exe
	http://www.stanford.edu/group/pandegroup/release/FAH3Console-v${PV/.}-Linux.exe"

SLOT="0"
IUSE=""
LICENSE="as-is"
KEYWORDS="~x86"

DEPEND=">=sys-apps/baselayout-1.8.0"

src_unpack() {
	mkdir -p ${S} ; cd ${S}
	if has_version \>=glibc-2.3.0; then
		cp ${DISTDIR}/FAH3Console-v${PV/.}-LinuxB.exe ${PN}
	else
		cp ${DISTDIR}/FAH3Console-v${PV/.}-Linux.exe ${PN}
	fi
}

pkg_preinst() {
	enewuser foldingathome -1 /bin/bash /opt/foldingathome
}

src_install() {
	exeinto ${I}
	doexe foldingathome
	doexe ${FILESDIR}/folding.sh
	doexe ${FILESDIR}/initfolding
	exeinto /etc/init.d
	newexe ${FILESDIR}/folding-init.d-r1 foldingathome
}

pkg_postinst() {
	chown -R foldingathome:nogroup /opt/foldingathome
	einfo "To run Folding@home in the background at boot:"
	einfo " rc-update add foldingathome default"
	einfo ""
	einfo "For first run configuration, please run /opt/foldingathome/initfolding"
}

pkg_postrm() {
	einfo "Folding@home data files were not removed."
	einfo " Remove them manually from ${I}"
	einfo ""
}

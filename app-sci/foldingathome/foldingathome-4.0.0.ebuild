# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/foldingathome/foldingathome-4.0.0.ebuild,v 1.3 2004/03/26 12:13:49 phosphan Exp $

# no version number on this install dir since upgrades will be using same dir
# (data will be stored here too)
I="/opt/foldingathome"

inherit eutils

DESCRIPTION="Help simulate protein folding at home"
HOMEPAGE="http://folding.stanford.edu/"
SRC_URI="http://www.stanford.edu/group/pandegroup/release/FAH4Console-Linux.exe"
RESTRICT="nomirror"

SLOT="0"
IUSE=""
LICENSE="as-is"
KEYWORDS="x86"

DEPEND=">=sys-apps/baselayout-1.8.0
	>=sys-libs/glibc-2.3.0
	amd64? ( app-emulation/emul-linux-x86-baselibs )"

S="${WORKDIR}"

src_unpack() {
		cp "${DISTDIR}/${A}" ${PN}
}

src_install() {
	exeinto ${I}
	doexe foldingathome
	doexe ${FILESDIR}/folding.sh
	doexe ${FILESDIR}/initfolding
	exeinto /etc/init.d
	newexe ${FILESDIR}/folding-init.d-r1 foldingathome
}

pkg_preinst() {
	enewuser foldingathome -1 /bin/bash /opt/foldingathome
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

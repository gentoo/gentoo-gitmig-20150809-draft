# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/foldingathome/foldingathome-4.0.0-r2.ebuild,v 1.2 2005/02/03 17:14:46 lostlogic Exp $

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
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND=">=sys-apps/baselayout-1.8.0
	>=sys-libs/glibc-2.3.0
	amd64? ( app-emulation/emul-linux-x86-baselibs )"

S="${WORKDIR}"

src_unpack() {
		cp "${DISTDIR}/${A}" ${PN}
}

src_install() {
	exeinto ${I}
	newexe ${FILESDIR}/initfolding-r1 initfolding

	# Clients
	exeinto ${I}/client1
	doexe foldingathome
	exeinto ${I}/client2
	doexe foldingathome
	exeinto ${I}/client3
	doexe foldingathome
	exeinto ${I}/client4
	doexe foldingathome
	exeinto ${I}/client5
	doexe foldingathome
	exeinto ${I}/client6
	doexe foldingathome
	exeinto ${I}/client7
	doexe foldingathome
	exeinto ${I}/client8
	doexe foldingathome
	exeinto /etc/init.d
	newexe ${FILESDIR}/folding-init.d-r3 foldingathome

	insinto /etc/conf.d
	newins ${FILESDIR}/folding-conf.d foldingathome
}

pkg_preinst() {
	enewuser foldingathome -1 /bin/bash /opt/foldingathome
}

pkg_postinst() {
	chown -R foldingathome:nogroup /opt/foldingathome
	einfo "To run Folding@home in the background at boot:"
	einfo " rc-update add foldingathome default"
	einfo ""
	einfo "Please run ${I}/initfolding to configure your client"
	einfo "and edit /etc/conf.d/foldingathome for options"
	einfo ""
}

pkg_postrm() {
	einfo "Folding@home data files were not removed."
	einfo " Remove them manually from ${I}"
	einfo ""
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/foldingathome/foldingathome-6.29.ebuild,v 1.2 2010/06/22 06:29:37 jlec Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Folding@Home is a distributed computing project for protein folding."
HOMEPAGE="http://folding.stanford.edu/FAQ-SMP.html"
SRC_URI="http://www.stanford.edu/group/pandegroup/folding/release/FAH${PV}-Linux.tgz"

LICENSE="folding-at-home"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}"

I="opt/foldingathome"

QA_DT_HASH="${I}/.*"
QA_PRESTRIPPED="${I}/fah6"

pkg_setup() {
	I="${EPREFIX}/${I}"
}

src_install() {
	exeinto ${I}
	doexe "${FILESDIR}"/6.02/initfolding || die
	doexe fah6 mpiexec || die
	newconfd "${FILESDIR}"/6.02/folding-conf.d foldingathome || die
	newinitd "${FILESDIR}"/6.02/fah-init foldingathome || die
}

pkg_preinst() {
	# the bash shell is important for "su -c" in init script
	enewuser foldingathome -1 /bin/bash /opt/foldingathome
}

pkg_postinst() {
	chown -R foldingathome:nogroup "${EPREFIX}"/opt/foldingathome
	einfo "To run Folding@home in the background at boot:"
	einfo " rc-update add foldingathome default"
	einfo ""
	einfo "Please run ${I}/initfolding to configure your client"
	einfo "and edit ${EPREFIX}/etc/conf.d/foldingathome for options"
	einfo ""
	einfo "I encourage you to acquire a username and join team 36480."
	einfo "http://folding.stanford.edu/English/Download#ntoc2"
	einfo ""
}

pkg_postrm() {
	einfo "Folding@home data files were not removed."
	einfo " Remove them manually from ${I}"
	einfo ""
}

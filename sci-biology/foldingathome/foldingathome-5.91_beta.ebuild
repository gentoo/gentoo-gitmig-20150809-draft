# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/foldingathome/foldingathome-5.91_beta.ebuild,v 1.3 2007/07/03 04:26:15 je_fro Exp $

# no version number on this install dir since upgrades will be using same dir
# (data will be stored here too)
# The clientX files from old foldingathome will remain untouched.
I="/opt/foldingathome/amd64-smp"

inherit eutils

DESCRIPTION="Folding@Home is a distributed computing project for protein folding."
HOMEPAGE="http://folding.stanford.edu/FAQ-SMP.html"
SRC_URI="http://folding.stanford.edu/release/FAH_SMP_Linux.tgz"

LICENSE="folding-at-home"
SLOT="0"

# This beta just died...we're waiting on the next revision.
KEYWORDS=""
IUSE=""

DEPEND=">=sys-apps/baselayout-1.8.0
		>=sys-libs/glibc-2.3.0
		app-emulation/emul-linux-x86-baselibs"
RDEPEND=""

S="${WORKDIR}"

src_install() {
	exeinto ${I}
	newexe ${FILESDIR}/5.91_beta/initfolding initfolding
	doexe fah5 mpiexec
	newconfd ${FILESDIR}/5.91_beta/folding-conf.d foldingathome
	newinitd ${FILESDIR}/5.91_beta/fah-init foldingathome
}

pkg_preinst() {
	# the bash shell is important for "su -c" in init script
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
	einfo "This experimental F@H package exists alongside your old data files"
	einfo "in ${I}."
	einfo ""
}

pkg_postrm() {
	einfo "Folding@home data files were not removed."
	einfo " Remove them manually from ${I}"
	einfo ""
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mpi350-driver/mpi350-driver-2.0.ebuild,v 1.8 2004/11/05 01:27:21 vapier Exp $

DESCRIPTION="Cisco's wireless drivers and utilities"
HOMEPAGE="http://www.cisco.com/"
SRC_URI="Linux-ACU-Driver-v2.0.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="fetch"

DEPEND=""

MOD_DIR="/lib/modules/${KV}"
KERNEL_SRC="${ROOT}/usr/src/linux"

# ------------------------------------------------- #
# The script that Cisco provides is basically
# WORH (works on redhat) and doesn't mesh w/
# portage at all. Thus this ebuild does everything
# by hand, not using any of the scripts in their
# package.
# ------------------------------------------------- #

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from"
	einfo "http://www.cisco.com/public/sw-center/sw-wireless.shtml"
	einfo "and put it in ${DISTDIR}"
}

src_compile() {
	# Compile and install the drivers. the script that cisco provides
	# with the package stinks. Doesn't allow for DESTDIR or anything
	# Thus we compile them by hand here.

	cd ${S}/driver
	$(tc-getCC) -MD -Wall -I${KERNEL_SRC}/include -D__KERNEL__ -DMODULE -c ${S}/driver/mpi350.c || die
}

src_install() {
	# Install the drivers into the right place

	dodir ${MOD_DIR}/net

	cp ${S}/driver/mpi350.o ${D}/${MOD_DIR}/net


	# Next we install the utilities. They're binaries, so we simply
	# put them in the right place.

	cd ${S}/utilities

	dodir /opt/cisco/bin
	exeinto /opt/cisco/bin
	doexe acu bcard leapset leapscript leaplogin

	# Install the helpml stuff

	cd ${S}
	tar xfz ${S}/helpml.tar.gz
	dodir /opt/cisco/helpml
	cp ${S}/helpml/* ${D}/opt/cisco/helpml/

	cp ${S}/ACU.PRFS ${D}/opt/cisco

	cd ${S}
	dodoc ethX.cfg readme.txt
}

pkg_postinst() {
	einfo "The cisco utilities are placed in /opt/cisco/bin"
	einfo "To use them either add them to your PATH, or"
	einfo "specify the full path to them."

	einfo "You need to gunzip ethX.cfg from /usr/share/doc/${P}"
	einfo "and copy it to /etc/ethX.cfg where X is the number ethernet"
	einfo "device using the cisco driver."
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/yaboot-static/yaboot-static-1.3.13.ebuild,v 1.1 2005/04/07 03:37:51 dostrow Exp $

DESCRIPTION="Static yaboot ppc boot loader for machines with open firmware"

HOMEPAGE="http://penguinppc.org/projects/yaboot/"
SRC_URI="mirror://gentoo/yaboot-static-${PVR}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc64 -*"
IUSE="ibm"
DEPEND="!sys-apps/yaboot
		sys-apps/powerpc-utils"
RDEPEND="!ibm? ( sys-fs/hfsutils )
		!ibm? ( sys-fs/hfsplusutils )"
PROVIDE="virtual/bootloader"

src_install() {
	# don't blow away the user's old conf file
	mv ${WORKDIR}/etc/yaboot.conf ${WORKDIR}/etc/yaboot.conf.unconfigured
	cp -a ${WORKDIR}/* ${D}/
	}


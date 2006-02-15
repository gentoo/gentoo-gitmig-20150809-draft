# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/yaboot-static/yaboot-static-1.3.12.ebuild,v 1.6 2006/02/15 03:35:32 dostrow Exp $

DESCRIPTION="Static yaboot ppc boot loader for machines with open firmware"

HOMEPAGE="http://penguinppc.org/projects/yaboot/"
SRC_URI="mirror://gentoo/yaboot-static-${PVR}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc64"
IUSE=""
DEPEND="!sys-boot/yaboot
		sys-apps/powerpc-utils
		sys-fs/hfsutils
		sys-fs/hfsplusutils"
PROVIDE="virtual/bootloader"

src_install() {
	# don't blow away the user's old conf file
	mv ${WORKDIR}/etc/yaboot.conf ${WORKDIR}/etc/yaboot.conf.unconfigured
	cp -pPR ${WORKDIR}/* ${D}/
	}


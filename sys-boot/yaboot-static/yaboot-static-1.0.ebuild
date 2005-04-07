# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/yaboot-static/yaboot-static-1.0.ebuild,v 1.4 2005/04/07 03:37:51 dostrow Exp $

DESCRIPTION="Static yaboot ppc boot loader for machines with open firmware"

HOMEPAGE="http://penguinppc.org/projects/yaboot/"
SRC_URI="mirror://gentoo/yaboot-static-${PVR}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc64 -*"
IUSE=""
DEPEND="!sys-apps/yaboot"
PROVIDE="virtual/bootloader"

src_install() {
	cp -a ${WORKDIR}/* ${D}/
	}


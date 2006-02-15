# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/grub-static/grub-static-0.93.20030118.ebuild,v 1.3 2006/02/15 02:52:08 tester Exp $

DESCRIPTION="Static GNU GRUB boot loader"

HOMEPAGE="http://www.gnu.org/software/grub/"
SRC_URI="mirror://gentoo/grub-static-${PVR}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86 -ppc -sparc -alpha -mips -hppa"
IUSE=""
DEPEND="!sys-boot/grub"
PROVIDE="virtual/bootloader"

src_install() {
	cp -a ${WORKDIR}/* ${D}/
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/grub-static/grub-static-0.93.20030118.ebuild,v 1.1 2003/12/09 08:12:17 seemant Exp $

DESCRIPTION="Static GNU GRUB boot loader"

HOMEPAGE="http://www.gnu.org/software/grub/"
SRC_URI="mirror://gentoo/grub-static-${PVR}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86 -ppc -sparc -alpha -mips -hppa"
IUSE=""
DEPEND="!sys-apps/grub"
PROVIDE="virtual/bootloader"

src_install() {
	cp -a ${WORKDIR}/* ${D}/
}

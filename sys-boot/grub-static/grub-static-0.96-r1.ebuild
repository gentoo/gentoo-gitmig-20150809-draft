# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/grub-static/grub-static-0.96-r1.ebuild,v 1.2 2006/09/07 11:39:49 blubb Exp $

DESCRIPTION="Static GNU GRUB boot loader"

HOMEPAGE="http://www.gnu.org/software/grub/"
SRC_URI="mirror://gentoo/grub-static-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 ~x86"
IUSE=""
DEPEND="!sys-boot/grub"
PROVIDE="virtual/bootloader"

src_install() {
	cp -a ${WORKDIR}/* ${D}/
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/cromwell-bin/cromwell-bin-2.31.ebuild,v 1.1 2004/10/16 15:24:27 chrb Exp $

inherit mount-boot

IUSE=""
DESCRIPTION="Xbox boot loader precompiled binaries from xbox-linux.org"
SRC_URI="mirror://sourceforge/xbox-linux/cromwell-${PV}.tar.gz"
HOMEPAGE="http://www.xbox-linux.org"
RESTRICT="${RESTRICT} nostrip"
DEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
PROVIDE="virtual/bootloader"
S=${WORKDIR}/cromwell

src_install () {
	dodir /boot/${PN}
	insinto /boot/${PN}
	doins ${S}/image.bin ${S}/image_1024.bin ${S}/default.xbe || die
}

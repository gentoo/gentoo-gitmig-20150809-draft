# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/cromwell-bin/cromwell-bin-2.40.ebuild,v 1.1 2005/08/10 20:19:36 chrb Exp $

inherit mount-boot

IUSE=""
DESCRIPTION="Xbox boot loader precompiled binaries from xbox-linux.org"
SRC_URI="mirror://sourceforge/xbox-linux/cromwell-${PV}.tar.gz"
HOMEPAGE="http://www.xbox-linux.org"
RESTRICT="${RESTRICT} nostrip"
DEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* x86"
PROVIDE="virtual/bootloader"
S=${WORKDIR}/cromwell-${PV}

src_install () {
	dodir /boot/${PN}
	insinto /boot/${PN}
	doins ${S}/cromwell.bin ${S}/cromwell_1024.bin ${S}/xromwell.xbe || die
}

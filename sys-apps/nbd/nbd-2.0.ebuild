# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nbd/nbd-2.0.ebuild,v 1.3 2004/04/04 19:28:19 vapier Exp $

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sourceforge.net/"
SRC_URI="mirror://sourceforge/nbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc amd64"

DEPEND="virtual/glibc"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die
	make || die
	make -C gznbd || die
}

src_install() {
	dobin nbd-client nbd-server gznbd/gznbd || die
	dodoc README
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-3.0.1_rc1.ebuild,v 1.3 2004/03/09 18:16:25 mr_bones_ Exp $

IUSE=""

DESCRIPTION="Gentoo autokernel script"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86 sparc hppa alpha ppc"

DEPEND="amd64? ( media-gfx/bootsplash )
	x86? ( media-gfx/bootsplash )"

src_install() {
	dodir /etc
	cp ${S}/genkernel.conf ${D}/etc

	dodir /usr/bin
	cp ${S}/genkernel ${D}/usr/bin

	dodir /usr/share/genkernel
	cp -Rpv ${S}/* ${D}/usr/share/genkernel

	rm -f ${D}/usr/share/genkernel/genkernel.conf
	rm -f ${D}/usr/share/genkernel/genkernel
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-3.0.2b.ebuild,v 1.2 2004/06/15 20:30:42 zhen Exp $

IUSE=""

DESCRIPTION="Gentoo autokernel script"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~plasmaroo/patches/kernel/genkernel/3.0.2/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~sparc ~hppa ~alpha ~ppc ~arm ~s390"

DEPEND="amd64? ( media-gfx/bootsplash )
	x86? ( media-gfx/bootsplash )"

src_install() {
	dodir /etc
	cp ${S}/genkernel.conf ${D}/etc

	dodir /usr/share/genkernel
	cp -Rp ${S}/* ${D}/usr/share/genkernel

	dodir /usr/bin
	dosym ${D}/usr/share/genkernel/genkernel /usr/bin/genkernel

	rm ${D}/usr/share/genkernel/genkernel.conf
}

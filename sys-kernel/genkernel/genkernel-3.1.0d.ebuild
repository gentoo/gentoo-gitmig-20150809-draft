# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-3.1.0d.ebuild,v 1.1 2004/12/21 13:04:36 plasmaroo Exp $

DESCRIPTION="Gentoo autokernel script"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~plasmaroo/patches/kernel/genkernel/3.1.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="bootsplash"

DEPEND="sys-fs/e2fsprogs
	x86? ( bootsplash? ( media-gfx/bootsplash ) )
	amd64? ( bootsplash? ( media-gfx/bootsplash ) )"

src_install() {
	dodir /etc
	cp ${S}/genkernel.conf ${D}/etc

	dodir /usr/share/genkernel
	cp -Rp ${S}/* ${D}/usr/share/genkernel

	dodir /usr/bin
	dosym /usr/share/genkernel/genkernel /usr/bin/genkernel

	rm ${D}/usr/share/genkernel/genkernel.conf
	dodoc README

	doman genkernel.8
	rm genkernel.8
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-3.0.2c-r1.ebuild,v 1.1 2004/10/02 11:55:25 lv Exp $

DESCRIPTION="Gentoo autokernel script"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~plasmaroo/patches/kernel/genkernel/3.0.2/${P}.tar.bz2
	http://dev.gentoo.org/~lv/genkernel-updated-x86_64-configs.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="bootsplash"

DEPEND="x86? ( bootsplash? ( media-gfx/bootsplash ) )
	amd64? ( bootsplash? ( media-gfx/bootsplash ) )"

src_unpack() {
	unpack genkernel-3.0.2c.tar.bz2
	cd ${S}
	unpack genkernel-updated-x86_64-configs.tar.bz2
}

src_install() {
	dodir /etc
	cp ${S}/genkernel.conf ${D}/etc

	dodir /usr/share/genkernel
	cp -Rp ${S}/* ${D}/usr/share/genkernel

	dodir /usr/bin
	dosym /usr/share/genkernel/genkernel /usr/bin/genkernel

	rm ${D}/usr/share/genkernel/genkernel.conf
	dodoc README
}

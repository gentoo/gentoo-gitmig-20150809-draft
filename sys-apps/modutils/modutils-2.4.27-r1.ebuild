# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/modutils/modutils-2.4.27-r1.ebuild,v 1.6 2012/02/25 07:09:43 robbat2 Exp $

inherit eutils

DESCRIPTION="Standard kernel module utilities for linux-2.4 and older"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/modutils/"
SRC_URI="mirror://kernel/linux/utils/kernel/${PN}/v2.4/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="!sys-apps/module-init-tools
	!sys-apps/kmod"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-alias.patch
	epatch "${FILESDIR}"/${P}-gcc.patch
	epatch "${FILESDIR}"/${P}-flex.patch
	epatch "${FILESDIR}"/${P}-no-nested-function.patch
}

src_compile() {
	econf \
		--prefix=/ \
		--disable-strip \
		--enable-insmod-static \
		--disable-zlib \
		|| die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall prefix="${D}" || die "make install failed"
	dodoc CREDITS ChangeLog NEWS README TODO
}

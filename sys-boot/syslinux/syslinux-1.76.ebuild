# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/syslinux/syslinux-1.76.ebuild,v 1.2 2008/07/21 23:21:18 chainsaw Exp $

DESCRIPTION="SysLinux, IsoLinux and PXELinux bootloader"
HOMEPAGE="http://syslinux.zytor.com/"
SRC_URI="mirror://kernel/linux/utils/boot/syslinux/Old/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND="dev-lang/nasm"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/^#/s:^#: #:' memdisk/init.S16 || die "fixing # comments"
}

src_compile() {
	emake -j1 depend || die "make depend failed"
	emake || die "make failed"
}

src_install() {
	make INSTALLROOT="${D}" install || die
	dodoc README NEWS TODO *.doc
}

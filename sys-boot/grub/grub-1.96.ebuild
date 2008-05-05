# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/grub/grub-1.96.ebuild,v 1.3 2008/05/05 03:37:21 vapier Exp $

inherit mount-boot eutils flag-o-matic toolchain-funcs

DESCRIPTION="GNU GRUB 2 boot loader"
HOMEPAGE="http://www.gnu.org/software/grub/"
SRC_URI="ftp://alpha.gnu.org/gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="static netboot custom-cflags"

DEPEND=">=sys-libs/ncurses-5.2-r5
	dev-libs/lzo"
PROVIDE="virtual/bootloader"

src_compile() {
	use amd64 && multilib_toolchain_setup x86
	use custom-cflags || unset CFLAGS CPPFLAGS LDFLAGS
	use static && append-ldflags -static

	econf \
		--prefix=/ \
		--datadir=/usr/lib \
		|| die "econf failed"
	emake -j1 || die "making regular stuff"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}

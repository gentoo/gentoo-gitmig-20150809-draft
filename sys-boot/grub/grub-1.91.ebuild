# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/grub/grub-1.91.ebuild,v 1.1 2005/11/25 19:47:19 vapier Exp $

inherit mount-boot eutils flag-o-matic toolchain-funcs

DESCRIPTION="GNU GRUB 2 boot loader"
HOMEPAGE="http://www.gnu.org/software/grub/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	ftp://alpha.gnu.org/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="-*"
IUSE="static netboot custom-cflags"

DEPEND=">=sys-libs/ncurses-5.2-r5"
PROVIDE="virtual/bootloader"

pkg_setup() {
	if use amd64 ; then
		if ! has_m32 ; then
			eerror "Your compiler seems to be unable to compile 32bit code."
			eerror "If you are on amd64, make sure you compile gcc with:"
			echo
			eerror "    USE=multilib FEATURES=-sandbox"
			die "Cannot produce 32bit objects!"
		fi

		ABI_ALLOW="x86"
		ABI="x86"
	fi
}

src_compile() {
	use custom-cflags || unset CFLAGS
	use static && append-ldflags -static

	econf \
		--prefix=/ \
		--datadir=/usr/lib \
		|| die "econf failed"
	emake || die "making regular stuff"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}

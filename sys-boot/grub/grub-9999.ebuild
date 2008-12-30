# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/grub/grub-9999.ebuild,v 1.2 2008/12/30 02:18:04 vapier Exp $

inherit mount-boot eutils flag-o-matic toolchain-funcs

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="svn://svn.sv.gnu.org/grub/trunk/grub2"
	inherit subversion
	SRC_URI=""
else
	SRC_URI="ftp://alpha.gnu.org/gnu/${PN}/${P}.tar.gz
		mirror://gentoo/${P}.tar.gz"
fi

DESCRIPTION="GNU GRUB 2 boot loader"
HOMEPAGE="http://www.gnu.org/software/grub/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="static custom-cflags"

DEPEND=">=sys-libs/ncurses-5.2-r5
	dev-libs/lzo"
PROVIDE="virtual/bootloader"

STRIP_MASK="/lib*/grub/*/*.mod"

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

pkg_postinst() {
	elog "To automatically generate a grub configuration file:"
	elog "# /sbin/grub-mkconfig -o /boot/grub/grub.cfg"
}

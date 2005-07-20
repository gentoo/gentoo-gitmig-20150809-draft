# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libvserver/libvserver-0.2.ebuild,v 1.1 2005/07/20 06:25:03 hollow Exp $

DESCRIPTION="Linux-VServer syscall library"
HOMEPAGE="http://dev.gentoo.org/~hollow/vserver/libvserver"
SRC_URI="${HOMEPAGE}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="alt-syscall"
DEPEND=""

src_compile() {
	local myconf

	use alt-syscall && myconf="--enable-alt-syscall --disable-shared"

	econf ${myconf}
	emake
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

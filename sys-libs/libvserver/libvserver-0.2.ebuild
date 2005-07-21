# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libvserver/libvserver-0.2.ebuild,v 1.2 2005/07/21 07:56:02 dholm Exp $

DESCRIPTION="Linux-VServer syscall library"
HOMEPAGE="http://dev.gentoo.org/~hollow/vserver/libvserver"
SRC_URI="${HOMEPAGE}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

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

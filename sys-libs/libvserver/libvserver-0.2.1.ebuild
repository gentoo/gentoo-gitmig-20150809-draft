# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libvserver/libvserver-0.2.1.ebuild,v 1.1 2005/07/23 08:28:52 hollow Exp $

DESCRIPTION="Linux-VServer syscall library"
HOMEPAGE="http://dev.gentoo.org/~hollow/vserver/libvserver"
SRC_URI="${HOMEPAGE}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE="diet"
DEPEND="diet? ( >=dev-libs/dietlibc-0.28 )"

src_compile() {
	local myconf

	use diet && myconf="--enable-dietlibc --disable-shared"

	econf ${myconf}
	emake
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

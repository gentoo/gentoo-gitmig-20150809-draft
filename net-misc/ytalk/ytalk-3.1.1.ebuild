# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ytalk/ytalk-3.1.1.ebuild,v 1.19 2004/11/25 22:20:53 sekretarz Exp $

DESCRIPTION="Multi-user replacement for UNIX talk"
HOMEPAGE="http://www.iagora.com/~espel/ytalk/ytalk.html"
SRC_URI="http://www.iagora.com/~espel/ytalk/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 sparc ppc alpha amd64"
IUSE="X"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2
	X? ( virtual/x11 )"

src_compile() {
	local myconf=""
	use X || myconf="$myconf --without-x" #default enabled

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} \
	|| die "./configure failed"

	emake || die "Parallel Make Failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die "Installation Failed"

	dodoc BUGS ChangeLog INSTALL README README.old
}

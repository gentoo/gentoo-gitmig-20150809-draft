# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ytalk/ytalk-3.1.1.ebuild,v 1.12 2004/01/14 18:23:54 agriffis Exp $

IUSE="X"

S=${WORKDIR}/${P}

DESCRIPTION="Multi-user replacement for UNIX talk"
SRC_URI="http://www.iagora.com/~espel/ytalk/${P}.tar.gz"
HOMEPAGE="http://www.iagora.com/~espel/ytalk/ytalk.html"
KEYWORDS="x86 sparc  ppc ~alpha"
LICENSE="freedist"
SLOT="0"

DEPEND="virtual/glibc
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



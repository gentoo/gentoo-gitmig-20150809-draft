# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/ytalk/ytalk-3.1.1.ebuild,v 1.4 2002/08/14 12:08:08 murphy Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Multi-user replacement for UNIX talk"
SRC_URI="http://www.iagora.com/~espel/ytalk/${P}.tar.gz"
HOMEPAGE="http://www.iagora.com/~espel/ytalk/ytalk.html"
KEYWORDS="x86 sparc sparc64"
LICENSE="ytalk"
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



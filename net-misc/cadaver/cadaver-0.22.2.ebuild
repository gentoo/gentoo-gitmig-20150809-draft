# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cadaver/cadaver-0.22.2.ebuild,v 1.5 2004/09/16 03:34:42 tgall Exp $

DESCRIPTION="a command-line WebDAV client."
HOMEPAGE="http://www.webdav.org/cadaver"
SRC_URI="http://www.webdav.org/cadaver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ppc64"
IUSE="ssl"

DEPEND="virtual/libc"

src_compile() {

	myconf=" --host=${CHOST} --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man"
	use ssl && myconf="${myconf} --with-ssl"
	./configure ${myconf} || die "./configure failed"
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	dodoc BUGS ChangeLog COPYING FAQ INSTALL NEWS README THANKS TODO
}


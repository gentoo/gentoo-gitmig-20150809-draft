# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cadaver/cadaver-0.22.2.ebuild,v 1.3 2004/07/01 20:48:57 squinky86 Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="a command-line WebDAV client."
SRC_URI="http://www.webdav.org/cadaver/${P}.tar.gz"
HOMEPAGE="http://www.webdav.org/cadaver"
LICENSE="GPL-2"
#DEPEND=">=net-misc/neon-0.23.5"
DEPEND="virtual/libc"
KEYWORDS="x86 ~ppc ~sparc"
SLOT="0"
IUSE=""

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


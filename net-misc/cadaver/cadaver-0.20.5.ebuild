# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cadaver/cadaver-0.20.5.ebuild,v 1.4 2003/09/05 22:13:37 msterret Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="a command-line WebDAV client."
SRC_URI="http://www.webdav.org/cadaver/${P}.tar.gz"
HOMEPAGE="http://www.webdav.org/cadaver"
LICENSE="GPL-2"
#DEPEND=">=net-misc/neon-0.23.5"
DEPEND="virtual/glibc"
KEYWORDS="x86"
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


# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/neon/neon-0.19.2-r1.ebuild,v 1.7 2003/04/23 07:59:43 pauldv Exp $

S=${WORKDIR}/${P}
DESCRIPTION="HTTP and WebDAV client library"
SRC_URI="http://www.webdav.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.webdav.org/neon"
DEPEND="dev-libs/libxml2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="ssl"

src_compile() {
	local myconf
	
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml"
	CXXFLAGS="${CXXFLAGS} -I/usr/include/libxml2/libxml"

	if [ "`use ssl`" ] ; then
	    myconf="$myconf --with-ssl"
	fi
	
	./configure \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--host=${CHOST} \
		--enable-shared $myconf || die 

	emake || die
}

src_install () {

	make prefix=${D}/usr install || die

}


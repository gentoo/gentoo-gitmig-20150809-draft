# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/neon/neon-0.19.2-r1.ebuild,v 1.3 2002/07/11 06:30:48 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="HTTP and WebDAV client library"
SRC_URI="http://www.webdav.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.webdav.org/neon"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-libs/libxml2"

src_compile() {
	local myconf
	
CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml"
CXXFLAGS="${CXXFLAGS} -I/usr/include/libxml2/libxml"
	if [ "`use ssl`" ] ; then
	    myconf="$myconf --with-ssl"
	fi
	
	./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} --enable-shared $myconf || die 

	emake || die
}

src_install () {

	make prefix=${D}/usr install || die

}


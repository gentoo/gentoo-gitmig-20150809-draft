# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/neon/neon-0.18.5.ebuild,v 1.1 2002/02/08 01:32:20 gbevin Exp $

S=${WORKDIR}/${P}

DESCRIPTION="HTTP and WebDAV client library"

SRC_URI="http://www.webdav.org/${PN}/${P}.tar.gz"

HOMEPAGE="http://www.webdav.org/neon"

DEPEND="dev-libs/libxml2"

src_compile() {
	local myconf
	
	if [ "`use ssl`" ] ; then
	    myconf="$myconf --with-ssl"
	fi
	
	./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} --enable-shared $myconf || die 

	emake || die
}

src_install () {

	make prefix=${D}/usr install || die

}


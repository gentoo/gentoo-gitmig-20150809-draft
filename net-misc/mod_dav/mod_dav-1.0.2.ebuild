# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/mod_dav/mod_dav-1.0.2.ebuild,v 1.2 2001/11/07 13:15:36 achim Exp $

S=${WORKDIR}/${P}-1.3.6

DESCRIPTION="WebDAV module for Apache 1.3.6 or later"

SRC_URI="http://www.webdav.org/mod_dav/mod_dav-1.0.2-1.3.6.tar.gz"

HOMEPAGE="http://www.webdav.org/mod_dav/"

DEPEND=">=net-www/apache-1.3.6
        >=dev-libs/expat-1.95.1-r1"

# FIXME: This will only work if apache has been compiled dynamically

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-apxs=/usr/sbin/apxs \
		--mandir=/usr/share/man || die
	emake || die
}

src_install () {

	dodoc CHANGES INSTALL README LICENSE.html

	local confdir=`/usr/sbin/apxs -q SYSCONFDIR`
	local libexecdir=`/usr/sbin/apxs -q LIBEXECDIR`
	local includedir=`/usr/sbin/apxs -q INCLUDEDIR`
		
	dodir ${libexecdir}

	exeinto ${libexecdir}
	doexe libdav.so
	
	insinto ${includedir}
	doins mod_dav.h
}

pkg_config() {

	 /usr/sbin/apxs -e -a -n dav /usr/lib/apache/libdav.so
	 
	 echo ">>> You might want to tweak your `/usr/sbin/apxs -q SYSCONFDIR`/httpd.conf now"
}

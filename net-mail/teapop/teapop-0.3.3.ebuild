# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/teapop/teapop-0.3.3.ebuild,v 1.3 2002/05/02 01:46:57 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tiny POP3 server"
SRC_URI="ftp://ftp.toontown.org/pub/teapop/teapop-0.3.3.tar.gz"
HOMEPAGE="http://www.toontown.org/teapop/"
DEPEND=""

src_compile() {
	local myconf 
	use mysql && myconf="$myconf --enable-mysql"
	use postgres && myconf="$myconf --enable-pgsql"
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--enable-lock=flock,dotlock \
		--enable-homespool=mail \
		--enable-mailsppol=/var/spool/mail \
		--mandir=/usr/share/man \
		--enable-apop \
		$myconf || die "./configure failed"
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc \
		install || die

	dodir /usr/sbin
	mv ${D}/usr/libexec/teapop ${D}/usr/sbin/
	
	dodoc doc/{CREDITS,ChangeLog,INSTALL,TODO}
	
	docinto contrib
	dodoc contrib/{README,popauther3.pl,teapop+exim.txt}
	dohtml contrib/*.html
	
	docinto rfc
	dodoc rfc/rfc*.txt

}

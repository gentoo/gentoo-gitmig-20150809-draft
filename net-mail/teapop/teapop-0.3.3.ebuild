# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/teapop/teapop-0.3.3.ebuild,v 1.11 2003/09/05 08:57:36 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tiny POP3 server"
SRC_URI="ftp://ftp.toontown.org/pub/teapop/${P}.tar.gz"
HOMEPAGE="http://www.toontown.org/teapop/"
DEPEND=""

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc "

src_compile() {
	local myconf
	use mysql && myconf="${myconf} --enable-mysql"
	use postgres && myconf="${myconf} --enable-pgsql"
	econf \
		--enable-lock=flock,dotlock \
		--enable-homespool=mail \
		--enable-mailspool=/var/spool/mail \
		--enable-apop \
		${myconf} || die "./configure failed"
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

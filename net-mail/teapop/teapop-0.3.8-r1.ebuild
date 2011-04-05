# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/teapop/teapop-0.3.8-r1.ebuild,v 1.7 2011/04/05 15:37:50 vostorga Exp $

DESCRIPTION="Tiny POP3 server"
SRC_URI="ftp://ftp.toontown.org/pub/teapop/${P}.tar.gz"
HOMEPAGE="http://www.toontown.org/teapop/"
DEPEND="mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-server )
	ldap? ( >=net-nds/openldap-2.0.25 )
	tcpd? ( sys-apps/tcp-wrappers )
	java? ( virtual/jre )"
IUSE="mysql postgres ldap ipv6 tcpd java virtual"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~sparc ~ppc"

src_compile() {
	local myconf
	use mysql && myconf="${myconf} --with-mysql=/usr"
	use postgres && myconf="${myconf} --with-pgsql=/usr"
	use ldap && myconf="${myconf} --with-ldap=openldap"
	use java && myconf="${myconf} --with-java=${JAVA_HOME}"
	use virtual || myconf="${myconf} --disable-vpop"

	econf \
		--enable-lock=flock,dotlock \
		--enable-homespool=mail \
		--enable-mailspool=/var/spool/mail \
		--enable-apop \
		$( use_enable ipv6 ) \
		$( use_with tcpd ) \
		${myconf} || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR="${D}" STRIP=nostrip install || die

	dodir /usr/sbin
	mv "${D}"/usr/libexec/teapop "${D}"/usr/sbin/

	dodoc doc/{CREDITS,ChangeLog,INSTALL,TODO}

	docinto contrib
	dodoc contrib/{README,popauther3.pl,teapop+exim.txt}
	dohtml contrib/*.html

	docinto rfc
	dodoc rfc/rfc*.txt

	newinitd "${FILESDIR}"/teapop-init teapop
	newconfd "${FILESDIR}"/teapop-confd teapop
}

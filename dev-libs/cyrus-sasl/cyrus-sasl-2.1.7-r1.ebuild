# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cyrus-sasl/cyrus-sasl-2.1.7-r1.ebuild,v 1.11 2003/06/06 23:58:22 rphillips Exp $

IUSE="static mysql ldap gdbm kerberos berkdb"

S=${WORKDIR}/${P}

DESCRIPTION="The Cyrus SASL (Simple Authentication and Security Layer)"
HOMEPAGE="http://asg.web.cmu.edu/sasl/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc -sparc "

DEPEND=">=sys-libs/db-3.2
	>=sys-libs/pam-0.75
	>=dev-libs/openssl-0.9.6d
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	berkdb? ( >=sys-libs/db-3.2.9 )
	ldap? ( >=net-nds/openldap-2.0.25 )
	mysql? ( >=dev-db/mysql-3.23.51 )
	kerberos? ( >=app-crypt/mit-krb5-1.2.5 )"
	

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/cyrus-sasl-iovec.diff || die
	patch -p1 < ${FILESDIR}/crypt.diff || die

}

src_compile() {

	local myconf

	use ldap && myconf="${myconf} --with-ldap" \
		|| myconf="${myconf} --without-ldap"

	use mysql && myconf="${myconf} --with-mysql" \
		|| myconf="${myconf} --without-mysql"

	if use berkdb; then
		myconf="${myconf} --with-dblib=berkeley"
	elif use gdbm; then
		myconf="${myconf} --with-dblib=gdbm --with-gdbm=/usr"
	else
		myconf="${myconf} --with-dblib=berkeley"
	fi

	use static && myconf="${myconf} --enable-static --with-staticsasl" \
		|| myconf="${myconf} --disable-static --without-staticsasl"

	use kerberos && myconf="${myconf} --enable-krb4" \
		|| myconf="${myconf} --disable-krb4"	

	econf \
		--with-saslauthd=/var/lib/sasl2 \
		--with-pwcheck=/var/lib/sasl2 \
		--with-configdir=/etc/sasl2 \
		--with-openssl=/usr \
		--with-plugindir=/usr/lib/sasl2 \
		--with-dbpath=/etc/sasl2/sasldb2 \
		--with-des \
		--with-rc4 \
		--with-gnu-ld \
		--enable-shared \
		--disable-sample \
		--enable-login \
		${myconf} || die "bad ./configure"

	make || die "compile problem"
}

src_install () {
	make DESTDIR=${D} install || die "install problem"

	dodoc AUTHORS ChangeLog COPYING NEWS README doc/*.txt
	docinto examples ; dodoc sample/{*.[ch],Makefile}
	newdoc pwcheck/README README.pwcheck
	dohtml doc/*

	insinto /etc/conf.d ; newins ${FILESDIR}/saslauthd.confd saslauthd
	exeinto /etc/init.d ; newexe ${FILESDIR}/saslauthd2.rc6 saslauthd
	exeinto /etc/init.d ; newexe ${FILESDIR}/pwcheck.rc6 pwcheck
}

pkg_postinst() {

	# empty directories..
	dodir /var/lib/sasl2
	dodir /etc/sasl2

}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cyrus-sasl/cyrus-sasl-2.1.7.ebuild,v 1.3 2002/08/16 05:03:44 raker Exp $

DESCRIPTION="The Cyrus SASL (Simple Authentication and Security Layer)"
HOMEPAGE="http://asg.web.cmu.edu/sasl/"

S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND="virtual/glibc
	>=sys-libs/db-3.2
	>=sys-libs/pam-0.75
	>=dev-libs/openssl-0.9.6d
	gdbm? ( >=sys-libs/gdbm-1.8.0 )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/cyrus-sasl-2.1.6-iovec.diff
}

src_compile() {

	use gdbm && myconf="${myconf} --with-gdbm=/usr" \
		|| myconf="${myconf} --without-gdbm"
	

	econf \
		--with-saslauthd=/var/lib/sasl2 \
		--with-pwcheck=/var/lib/sasl2 \
		--with-configdir=/etc/sasl2 \
		--with-openssl=/usr \
		--with-plugindir=/usr/lib/sasl2 \
		--with-dbpath=/etc/sasl2/sasldb2 \
		--with-des \
		--with-rc4 \
		--enable-pam \
		--enable-anon \
		--enable-cram \
		--with-gnu-ld \
		--enable-scram \
		--enable-plain \
		--enable-login \
		--disable-krb4 \
		--enable-static \
		--enable-shared \
		--without-mysql \
		--enable-digest \
		--disable-gssapi \
		--disable-sample \
		--with-dblib=berkeley \
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
	install -d -m0755 ${ROOT}/var/lib/sasl2
	install -d -m0755 ${ROOT}/etc/sasl2
}

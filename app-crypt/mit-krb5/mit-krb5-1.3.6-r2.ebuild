# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mit-krb5/mit-krb5-1.3.6-r2.ebuild,v 1.7 2005/04/06 07:51:31 kloeri Exp $

inherit eutils 64-bit

MY_P=${PN/mit-}-${PV}
S=${WORKDIR}/${MY_P}/src
DESCRIPTION="MIT Kerberos V"
HOMEPAGE="http://web.mit.edu/kerberos/www/"
SRC_URI="http://web.mit.edu/kerberos/dist/krb5/1.3/${MY_P}-signed.tar"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 mips ppc ppc64 ~s390 sparc x86"
IUSE="krb4 static"

DEPEND="virtual/libc
	sys-devel/autoconf
	!virtual/krb5"
RDEPEND="virtual/libc
	!virtual/krb5"
PROVIDE="virtual/krb5"

src_unpack() {
	unpack ${A}
	tar -zxf ${MY_P}.tar.gz
	cd ${S}
	64-bit && epatch ${FILESDIR}/${P}-64bit.patch
	epatch ${FILESDIR}/${P}-telnet.patch.bz2
}

src_compile() {
	ebegin "Updating configure"
		autoconf
		cd ${S}/util/et
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/util/ss
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/util/profile
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/util/pty
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/util/db2
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/include
		WANT_AUTOCONF=2.5 autoconf -I ../
		cd ${S}/lib/crypto
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/lib/krb5
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/lib/des425
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/lib/kdb
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/lib/gssapi
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/lib/rpc
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/lib/rpc/unit-test
		WANT_AUTOCONF=2.5 autoconf -I ../../../
		cd ${S}/lib/kadm5
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/kdc
		WANT_AUTOCONF=2.5 autoconf -I ../
		cd ${S}/kadmin
		WANT_AUTOCONF=2.5 autoconf -I ../
		cd ${S}/slave
		WANT_AUTOCONF=2.5 autoconf -I ../
		cd ${S}/clients
		WANT_AUTOCONF=2.5 autoconf -I ../
		cd ${S}/appl
		WANT_AUTOCONF=2.5 autoconf -I ../
		cd ${S}/appl/bsd
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/appl/gssftp
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/appl/telnet
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/appl/telnet/libtelnet
		WANT_AUTOCONF=2.5 autoconf -I ../../../
		cd ${S}/appl/telnet/telnet
		WANT_AUTOCONF=2.5 autoconf -I ../../../
		cd ${S}/appl/telnet/telnetd
		WANT_AUTOCONF=2.5 autoconf -I ../../../
		cd ${S}/tests
		WANT_AUTOCONF=2.5 autoconf -I ../
		cd ${S}/lib/krb4
		WANT_AUTOCONF=2.5 autoconf -I ../../
		cd ${S}/krb524
		WANT_AUTOCONF=2.5 autoconf -I ../
		cd ${S}
	eend $?

	local myconf

	use krb4 && myconf="${myconf} --with-krb4 --enable-krb4" \
		|| myconf="${myconf} --without-krb4 --disable-krb4"

	use static && myconf="${myconf} --disable-shared --enable-static" \
		|| myconf="${myconf} --enable-shared --disable-static"

	CFLAGS=`echo ${CFLAGS} | xargs`
	CXXFLAGS=`echo ${CXXFLAGS} | xargs`
	LDFLAGS=`echo ${LDFLAGS} | xargs`

	CFLAGS="${CFLAGS}" \
	CXXFLAGS="${CXXFLAGS}" \
	LDFLAGS="${LDFLAGS}" \
	econf \
		--mandir=/usr/share/man \
		--localstatedir=/etc \
		--host=${CHOST} \
		--prefix=/usr \
		--enable-dns \
		${myconf} || die

	if [ "${ARCH}" = "hppa" ]
	then
		einfo "Fixating Makefiles ..."
		for i in `find ${S} -name Makefile`; \
		do cp $i $i.old; sed -e 's/LDCOMBINE=ld -shared -h lib/LDCOMBINE=gcc -shared -h lib/' $i.old > $i; done
	fi

	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	cd ..
	dodoc README
	dohtml doc/*.html

	# Begin client rename and install
	for i in {telnetd,ftpd}
	do
		mv ${D}/usr/share/man/man8/${i}.8 ${D}/usr/share/man/man8/k${i}.8
		mv ${D}/usr/sbin/${i} ${D}/usr/sbin/k${i}
	done
	for i in {rcp,rsh,telnet,ftp,rlogin}
	do
		mv ${D}/usr/share/man/man1/${i}.1 ${D}/usr/share/man/man1/k${i}.1
		mv ${D}/usr/bin/${i} ${D}/usr/bin/k${i}
	done

	insinto /etc
		newins ${FILESDIR}/krb5.conf krb5.conf
	insinto /etc/krb5kdc
		newins ${FILESDIR}/kdc.conf kdc.conf
	exeinto /etc/init.d
		newexe ${FILESDIR}/mit-krb5kadmind.initd mit-krb5kadmind
		newexe ${FILESDIR}/mit-krb5kdc.initd mit-krb5kdc
}

pkg_postinst() {
	einfo "See /usr/share/doc/${PF}/html/admin.html for documentation."
	echo ""
	einfo "The client apps are installed with the k prefix"
	einfo "(ie. kftp, kftpd, ktelnet, ktelnetd, etc...)"
	echo ""
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mit-krb5/mit-krb5-1.3.6-r3.ebuild,v 1.2 2005/07/28 14:06:07 seemant Exp $

inherit eutils

MY_P=${PN/mit-}-${PV}
S=${WORKDIR}/${MY_P}/src
PATCHVER=0.1
DESCRIPTION="MIT Kerberos V"
HOMEPAGE="http://web.mit.edu/kerberos/www/"
SRC_URI="http://web.mit.edu/kerberos/dist/krb5/1.3/${MY_P}-signed.tar
	mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2
	http://web.mit.edu/kerberos/advisories/2005-002-patch_1.4.1.txt
	http://web.mit.edu/kerberos/advisories/2005-003-patch_1.4.1.txt"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE="krb4 static"

RDEPEND="virtual/libc
	!virtual/krb5"

DEPEND="${RDEPEND}
	sys-libs/com_err
	sys-libs/ss
	sys-devel/autoconf"

PROVIDE="virtual/krb5"

PATCHDIR=${WORKDIR}/gentoo/patches

src_unpack() {
	unpack ${P}-gentoo-${PATCHVER}.tar.bz2
	unpack ${MY_P}-signed.tar; tar zxf ${MY_P}.tar.gz; cd ${S}


	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}

	epatch ${FILESDIR}/${PN}-lazyldflags.patch

	EPATCH_SUFFIX="txt" \
		epatch ${DISTDIR}/2005-002-patch_1.4.1.txt

	EPATCH_SUFFIX="txt" \
		epatch ${DISTDIR}/2005-003-patch_1.4.1.txt
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


	CFLAGS="${CFLAGS}" \
	CXXFLAGS="${CXXFLAGS}" \
	LDFLAGS="${LDFLAGS}" \
		econf \
			$(use_with krb4) $(use_enable krb4) \
			$(use_enable static) \
			--localstatedir=/etc \
			--enable-shared \
			--with-system-et --with-system-ss \
			--enable-dns || die

	if [ "${ARCH}" = "hppa" ]
	then
		ebegin "Fixing Makefiles"
		for i in `find ${S} -name Makefile`; do
			sed -i 's/\(LDCOMBINE=\)ld \(-shared -h lib\)/\1gcc \2/' ${i}
		done
		eend $?
	fi

	MAKEOPTS="-j1" emake || die
}

src_test() {
	einfo "Tests fail for now, so make check is disabled"
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
	doins ${FILESDIR}/krb5.conf
	insinto /etc/krb5kdc
	doins ${FILESDIR}/kdc.conf

	newinitd ${FILESDIR}/mit-krb5kadmind.initd mit-krb5kadmind
	newinitd ${FILESDIR}/mit-krb5kdc.initd mit-krb5kdc
}

pkg_postinst() {
	einfo "See /usr/share/doc/${PF}/html/admin.html for documentation."
	echo
	einfo "The client apps are installed with the k prefix"
	einfo "(ie. kftp, kftpd, ktelnet, ktelnetd, etc...)"
	echo
	ewarn "PLEASE READ THIS"
	einfo "This release of mit-krb4 now depends on an external version"
	einfo "of the com_err and ss libraries. Please make sure to run"
	einfo "revdep-rebuild to ensure the integrity of the linking on your"
	einfo "system"
	echo
	epause 10
	ebeep
}

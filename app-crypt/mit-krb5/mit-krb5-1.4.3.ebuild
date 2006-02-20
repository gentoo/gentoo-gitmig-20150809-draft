# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mit-krb5/mit-krb5-1.4.3.ebuild,v 1.9 2006/02/20 03:05:11 kumba Exp $

inherit eutils flag-o-matic versionator

MY_P=${P/mit-}
P_DIR=$(get_version_component_range 1-2)
S=${WORKDIR}/${MY_P}/src
DESCRIPTION="MIT Kerberos V"
HOMEPAGE="http://web.mit.edu/kerberos/www/"
SRC_URI="http://web.mit.edu/kerberos/dist/krb5/${P_DIR}/${MY_P}-signed.tar"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="krb4 static tcltk ipv6 doc tetex berkdb"

RDEPEND="virtual/libc
	!virtual/krb5"

DEPEND="${RDEPEND}
	sys-libs/com_err
	sys-libs/ss
	sys-devel/autoconf
	berkdb? ( >=sys-libs/db-4 )
	doc? ( tetex? ( virtual/tetex ) )"

PROVIDE="virtual/krb5"

src_unpack() {
	unpack ${MY_P}-signed.tar; tar zxf ${MY_P}.tar.gz; cd ${S}
	epatch ${FILESDIR}/${PN}-lazyldflags.patch
}

src_compile() {
	if use berkdb ; then
		export DB_HEADER="/usr/include/db_185.h"
		export DB_LIB="/usr/$(get_libdir)/libdb.so"
	fi

	econf \
		$(use_with krb4) \
		$(use_with tcltk tcl) \
		$(use_enable ipv6) \
		$(use_enable static) \
		$(use_with berkdb system-db) \
		--localstatedir=/etc \
		--enable-shared \
		--with-system-et --with-system-ss \
		--enable-dns-for-realm || die

	emake -j1 || die

	if use doc ; then
		cd ../doc
		rm man2html && ln -sf ${ROOT}/usr/bin/man2html

		make || die

		if use tetex ; then
			cd api
			make || die
		fi
	fi
}

src_test() {
	einfo "Testing is being debugged, disabled for now"
}

src_install() {
	make \
		DESTDIR=${D} \
		EXAMPLEDIR=/usr/share/doc/${PF}/examples \
		install || die

	cd ..
	dodoc README
	doinfo doc/*.texinfo

	if use doc
	then
		dohtml -r doc
		use tetex \
			&& dodoc doc/api/*.{tex,sty} \
			|| dodoc doc/api/*.ps

	fi

	for i in {telnetd,ftpd}
	do
		mv ${D}/usr/share/man/man8/${i}.8 ${D}/usr/share/man/man8/k${i}.8
		mv ${D}/usr/sbin/${i} ${D}/usr/sbin/k${i}
	done

	for i in {rcp,rsh,telnet,ftp}
	do
		mv ${D}/usr/share/man/man1/${i}.1 ${D}/usr/share/man/man1/k${i}.1
		mv ${D}/usr/bin/${i} ${D}/usr/bin/k${i}
	done





	newinitd ${FILESDIR}/mit-krb5kadmind.initd mit-krb5kadmind
	newinitd ${FILESDIR}/mit-krb5kdc.initd mit-krb5kdc

	insinto /etc
	doins ${FILESDIR}/k{rb5,dc}.conf
}

pkg_postinst() {

	if use doc
	then
		einfo "See /usr/share/doc/${PF}/html/admin.html for documentation."
		echo ""
	fi
	einfo "The client apps are installed with the mit- prefix"
	einfo "(ie. mit-ftp, mit-ftpd, mit-telnet, mit-telnetd, etc...)"
	echo ""
	ewarn "PLEASE READ THIS"
	einfo "This release of mit-krb5 now depends on an external version"
	einfo "of the com_err library.  Please make sure to run revdep-rebuild"
	einfo "to ensure the integrity of the linking on your system"
	echo ""
	epause 10
	ebeep

}

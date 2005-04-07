# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mit-krb5/mit-krb5-1.4.ebuild,v 1.1 2005/04/07 21:23:49 seemant Exp $

inherit eutils flag-o-matic versionator

MY_P=${P/mit-}
P_DIR=$(get_version_component_range 1-2)
S=${WORKDIR}/${MY_P}/src
DESCRIPTION="MIT Kerberos V"
HOMEPAGE="http://web.mit.edu/kerberos/www/"
SRC_URI="http://web.mit.edu/kerberos/dist/krb5/${P_DIR}/${MY_P}-signed.tar"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="krb4 static tcltk ipv6 doc tetex"

RDEPEND="virtual/libc"
#	!virtual/krb5"

DEPEND="${RDEPEND}
	sys-libs/com_err
	sys-libs/ss
	sys-devel/autoconf"

PROVIDE="virtual/krb5"

src_unpack() {
	unpack ${A}; tar -zxf ${MY_P}.tar.gz; cd ${S}
	epatch ${FILESDIR}/${P}-2005-001.patch
}

src_compile() {
	export DB_HEADER="/usr/include/db4.2/db_185.h"
	export DB_LIB="/usr/$(get_libdir)/libdb.so"

	econf \
		$(use_enable static) \
		$(use_with krb4) \
		$(use_enable ipv6) \
		$(use_with tcltk tcl) \
		--enable-shared \
		--with-system-et --with-system-ss --with-system-db \
		--enable-dns-for-realm \
		--program-prefix=mit- \
		--sysconfdir=/etc/kerberos || die
	#	--program-transform-name="s:\(.*\):mit-\1:" || die

	emake || die

	# Now, remake the ksu binary with -Wl,-z,now in CFLAGS
	append-ldflags "-Wl,-z,now"
	emake -C clients/ksu clean || die
	emake LDFLAGS="${LDFLAGS}" -C clients/ksu || die

	if use doc
	then
		cd ../doc
		rm man2html && ln -sf ${ROOT}/usr/bin/man2html

		make || die

		if use tetex
		then
			cd api
			make || die
		fi
	fi
}

src_install() {
	make \
		DESTDIR=${D} \
		EXAMPLEDIR=${D}/usr/share/doc/${PF}/examples \
		install || die
	
	cd ..
	dodoc README
	doinfo doc/*.texinfo

	if use doc
	then
		dohtml -r doc
		use tetex \
			&& dodoc doc/api/*.ps \
			|| dodoc doc/api/*.{tex,sty}

	fi

	newinitd ${FILESDIR}/mit-krb5kadmind.initd mit-krb5kadmind
	newinitd ${FILESDIR}/mit-krb5kdc.initd mit-krb5kdc
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
}

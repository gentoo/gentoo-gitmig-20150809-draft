# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/heimdal/heimdal-0.6.ebuild,v 1.1 2003/05/27 07:53:15 aliz Exp $

inherit libtool

DESCRIPTION="Kerberos 5 implementation from KTH"
SRC_URI="ftp://ftp.pdc.kth.se/pub/heimdal/src/${P}.tar.gz"
HOMEPAGE="http://www.pdc.kth.se/heimdal/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ~ppc"
IUSE="ssl ldap berkdb ipv6 krb4"
PROVIDE="virtual/krb5"

DEPEND="
	krb4? ( >=app-crypt/kth-krb-1.2.1 )
	ssl? ( dev-libs/openssl )
	berkdb? ( sys-libs/db )"
	# ldap? ( net-nds/openldap )
	# With this enabled, we create a multiple stage
	# circular dependency with USE="ldap kerberos"
	# -- Kain <kain@kain.org> 05 Dec 2002

src_unpack() {
	unpack ${A}

	cd ${S}/lib/krb5
	mv Makefile.in Makefile.in.bak
	sed "s:LIB_crypt = @LIB_crypt@:LIB_crypt = -lssl @LIB_crypt@:g" Makefile.in.bak >Makefile.in
}

src_compile() {

	elibtoolize
	
	aclocal -I cf || die "configure problem"
	autoheader || die "configure problem"
	automake -a || die "configure problem"
	autoconf || die "configure problem"

	local myconf

	use ssl && myconf="--with-openssl=/usr" || myconf="--without-openssl"

	#use ldap && myconf="${myconf} --with-open-ldap=/usr"

	use ipv6 || myconf="${myconf} --without-ipv6"

	use berkdb || myconf="${myconf} --without-berkely-db"
	use krb4 && myconf="${myconf} --with-krb4=/usr/athena --disable-shared" \
		|| myconf="${myconf} --enable-shared"

	econf ${myconf}

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		datadir=${D}/usr/share \
		localstatedir=${D}/var/lib \
		includedir=${D}/usr/include/heimdal \
		install || die

	#dodir /etc/env.d
	#cp ${FILESDIR}/01heimdal ${D}/etc/env.d

	dodoc COPYRIGHT ChangeLog README NEWS PROBLEMS TODO

    # Begin client rename and install
    for i in {telnetd,ftpd}
    do
        mv ${D}/usr/share/man/man8/${i}.8.gz ${D}/usr/share/man/man8/k${i}.8.gz
        mv ${D}/usr/sbin/${i} ${D}/usr/sbin/k${i}
    done
    for i in {rcp,rsh,telnet,ftp,rlogin}
    do
        mv ${D}/usr/share/man/man1/${i}.1.gz ${D}/usr/share/man/man1/k${i}.1.gz
        mv ${D}/usr/bin/${i} ${D}/usr/bin/k${i}
    done
}

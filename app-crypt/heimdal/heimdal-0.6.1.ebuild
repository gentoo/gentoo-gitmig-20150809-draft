# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/heimdal/heimdal-0.6.1.ebuild,v 1.1 2004/04/07 18:24:01 solar Exp $

inherit libtool eutils

DESCRIPTION="Kerberos 5 implementation from KTH"
SRC_URI="ftp://ftp.pdc.kth.se/pub/heimdal/src/${P}.tar.gz"
HOMEPAGE="http://www.pdc.kth.se/heimdal/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~ia64 ~amd64 ~hppa ~mips"
IUSE="ssl ldap berkdb ipv6"
PROVIDE="virtual/krb5"

DEPEND="
	ssl? ( dev-libs/openssl )
	berkdb? ( sys-libs/db )
	!app-crypt/kth-krb
	sys-devel/autoconf"
	# ldap? ( net-nds/openldap )
	# With this enabled, we create a multiple stage
	# circular dependency with USE="ldap kerberos"
	# -- Kain <kain@kain.org> 05 Dec 2002

src_unpack() {
	unpack ${A} ; cd ${S}

	#epatch ${FILESDIR}/${PN}-${PV:0:3}-gcc3.patch
	epatch ${FILESDIR}/${PN}-${PV:0:3}-rxapps.patch
	epatch ${FILESDIR}/${PN}-${PV:0:3}-berkdb.patch

	# Um, I don't think the below is doing anything since automake is
	# run in src_compile(), but I'll leave it alone since this ebuild
	# isn't mine... (16 Feb 2004 agriffis)
	cd ${S}/lib/krb5 || die
	sed -i "s:LIB_crypt = @LIB_crypt@:LIB_crypt = -lssl @LIB_crypt@:g" Makefile.in || die

}

src_compile() {

	elibtoolize

	aclocal -I cf || die "configure problem"
	autoheader || die "configure problem"
	automake -a || die "configure problem"
	autoconf || die "configure problem"

	local myconf="
		$(use_with ipv6)
		$(use_with berkdb berkely-db)
		--enable-shared"

	use ssl \
		&& myconf="--with-openssl=/usr" \
		|| myconf="--without-openssl"

	#use ldap && myconf="${myconf} --with-open-ldap=/usr"

	econf ${myconf}

	# editline archive is linked into shared objects, needs to be
	# built with -fPIC (16 Feb 2004 agriffis)
	sed -i -e '/^CFLAGS\>/s/$/ -fPIC/' lib/editline/Makefile || die

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

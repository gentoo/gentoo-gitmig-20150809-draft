# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/heimdal/heimdal-0.6.2-r1.ebuild,v 1.1 2004/07/16 18:40:15 rphillips Exp $

inherit libtool eutils

DESCRIPTION="Kerberos 5 implementation from KTH"
SRC_URI="ftp://ftp.pdc.kth.se/pub/heimdal/src/${P}.tar.gz"
HOMEPAGE="http://www.pdc.kth.se/heimdal/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~ia64 ~amd64 ~hppa ~mips"
IUSE="ssl berkdb ipv6 krb4"
PROVIDE="virtual/krb5"

RDEPEND="ssl? ( dev-libs/openssl )
	berkdb? ( sys-libs/db )
	krb4? ( >=app-crypt/kth-krb-1.2.2-r2 )
	!virtual/krb5"
	# ldap? ( net-nds/openldap )
	# With this enabled, we create a multiple stage
	# circular dependency with USE="ldap kerberos"
	# -- Kain <kain@kain.org> 05 Dec 2002

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/gcc
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${PN}-${PV:0:3}-rxapps.patch
	epatch ${FILESDIR}/${PN}-${PV:0:3}-berkdb.patch
	epatch ${FILESDIR}/${P}-fPIC.patch

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
		$(use_with berkdb berkeley-db)
		$(use_with ssl openssl)
		--enable-shared"

	use krb4 \
		&& myconf="${myconf} --with-krb4 --with-krb4-config=/usr/athena/bin/krb4-config" \
		|| myconf="${myconf} --without-krb4"

	#use ldap && myconf="${myconf} --with-open-ldap=/usr"

	econf ${myconf} || die "econf failed"
	emake prefix=/usr \
		sysconfdir=/etc \
		mandir=/usr/share/man \
		infodir=/usr/share/info \
		datadir=/usr/share \
		localstatedir=/var/lib \
		includedir=/usr/include/heimdal \
		|| die
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

	# Create symlinks for the includes
	cd ${D}/usr/include/ && \
		ln -s heimdal gssapi && \
		ln -s heimdal/krb5-types.h krb5-types.h \
	|| die "Creation of include symlinks failed."

	dodir /etc/init.d
	exeinto /etc/init.d

	doexe ${FILESDIR}/heimdal-kdc \
		${FILESDIR}/heimdal-kadmind \
		${FILESDIR}/heimdal-kpasswdd
}

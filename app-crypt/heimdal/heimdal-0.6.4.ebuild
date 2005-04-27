# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/heimdal/heimdal-0.6.4.ebuild,v 1.5 2005/04/27 18:20:01 seemant Exp $

inherit libtool eutils

PATCHVER=0.1
PATCH_P=${P%.*}-gentoo-patches-${PATCHVER}

DESCRIPTION="Kerberos 5 implementation from KTH"
HOMEPAGE="http://www.pdc.kth.se/heimdal/"
SRC_URI="ftp://ftp.pdc.kth.se/pub/heimdal/src/${P}.tar.gz
	mirror://gentoo/${PATCH_P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 mips ~sparc ppc x86"
IUSE="ssl berkdb ipv6 krb4 ldap"

RDEPEND="ssl? ( dev-libs/openssl )
	berkdb? ( sys-libs/db )
	krb4? ( >=app-crypt/kth-krb-1.2.2-r2 )
	ldap? ( net-nds/openldap )
	!virtual/krb5"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/gcc
	>=sys-apps/sed-4"

PROVIDE="virtual/krb5"

GENTOODIR=${WORKDIR}/gentoo

src_unpack() {
	unpack ${A} ; cd ${S}

	EPATCH_SUFFIX="patch" \
		epatch ${GENTOODIR}/patches
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
		$(use_with krb4)
		--enable-shared
		--includedir=/usr/include/heimdal
		--libexecdir=/usr/sbin"

	use krb4 \
		&& myconf="${myconf} --with-krb4 --with-krb4-config=/usr/athena/bin/krb4-config"

	use ldap && myconf="${myconf} --with-openldap=/usr"

	# Adding a second call to elibtoolize to fix bug 73140
	elibtoolize

	econf ${myconf} || die "econf failed"
	emake		|| die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc ChangeLog README NEWS TODO

	# Begin client rename and install
	for i in {telnetd,ftpd}
	do
		mv ${D}/usr/share/man/man8/{,k}${i}.8
		mv ${D}/usr/sbin/{,k}${i}
	done

	for i in {rcp,rsh,telnet,ftp}
	do
		mv ${D}/usr/share/man/man1/{,k}${i}.1
		mv ${D}/usr/bin/${i} ${D}/usr/bin/{,k}${i}
	done

	# Create symlinks for the includes
	dosym heimdal /usr/include/gssapi
	dosym heimdal/krb5-types.h /usr/include/krb5-types.h
	dosym heimdal/krb5.h /usr/include/krb5.h
	dosym heimdal/asn1_err.h /usr/include/asn1_err.h
	dosym heimdal/krb5_asn1.h /usr/include/krb5_asn1.h
	dosym heimdal/krb5_err.h /usr/include/krb5_err.h
	dosym heimdal/heim_err.h /usr/include/heim_err.h
	dosym heimdal/k524_err.h /usr/include/k524_err.h
	dosym heimdal/krb5-protos.h /usr/include/krb5-protos.h

	doinitd ${GENTOODIR}/configs/heimdal-kdc
	doinitd ${GENTOODIR}/configs/heimdal-kadmind
	doinitd ${GENTOODIR}/configs/heimdal-kpasswdd

	insinto /etc
	doins ${GENTOODIR}/configs/krb5.conf

	if use ldap; then
		insinto /etc/openldap/schema
		doins ${GENTOODIR}/configs/krb5-kdc.schema
	fi


	# default database dir
	keepdir /var/heimdal
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/heimdal/heimdal-0.6.3.ebuild,v 1.5 2004/09/15 00:32:24 weeve Exp $

inherit libtool eutils flag-o-matic

DESCRIPTION="Kerberos 5 implementation from KTH"
SRC_URI="ftp://ftp.pdc.kth.se/pub/heimdal/src/${P}.tar.gz"
HOMEPAGE="http://www.pdc.kth.se/heimdal/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 sparc ppc ~alpha ~ia64 amd64 ~hppa ~mips"
IUSE="ssl berkdb ipv6 krb4 ldap"
PROVIDE="virtual/krb5"

RDEPEND="ssl? ( dev-libs/openssl )
	berkdb? ( sys-libs/db )
	krb4? ( >=app-crypt/kth-krb-1.2.2-r2 )
	ldap? ( net-nds/openldap )
	!virtual/krb5"

	# With this enabled, we create a multiple stage
	# circular dependency with USE="ldap kerberos"
	# -- Kain <kain@kain.org> 05 Dec 2002

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/gcc
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}.all.patch
	cd ${S}
	epatch ${FILESDIR}/${P}-ldap-subtree.patch
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
		--enable-shared
		--includedir=/usr/include/heimdal
		--libexecdir=/usr/sbin"

	use krb4 \
		&& myconf="${myconf} --with-krb4 --with-krb4-config=/usr/athena/bin/krb4-config" \
		|| myconf="${myconf} --without-krb4"

	use ldap && myconf="${myconf} --with-openldap=/usr"

	append-ldflags -Wl,-z,now
	econf ${myconf} || die "econf failed"
	emake		|| die

}

src_install() {
	make DESTDIR=${D} \
		install || die

	dodoc ChangeLog README NEWS TODO

	# Begin client rename and install
	for i in {telnetd,ftpd}
	do
		mv ${D}/usr/share/man/man8/${i}.8.gz ${D}/usr/share/man/man8/k${i}.8.gz
		mv ${D}/usr/sbin/${i} ${D}/usr/sbin/k${i}
	done
	for i in {rshd,telnetd,ftpd}
	do
		mv ${D}/usr/share/man/man1/${i}.1.gz ${D}/usr/share/man/man1/k${i}.1.gz
		mv ${D}/usr/sbin/${i} ${D}/usr/sbin/k${i}
	done

	# Create symlinks for the includes
	cd ${D}/usr/include/ && \
		ln -s heimdal gssapi && \
		ln -s heimdal/krb5-types.h krb5-types.h && \
		ln -s heimdal/krb5.h krb5.h && \
		ln -s heimdal/asn1_err.h asn1_err.h && \
		ln -s heimdal/krb5_asn1.h krb5_asn1.h && \
		ln -s heimdal/krb5_err.h krb5_err.h && \
		ln -s heimdal/heim_err.h heim_err.h && \
		ln -s heimdal/k524_err.h k524_err.h && \
		ln -s heimdal/krb5-protos.h krb5-protos.h \
	|| die "Creation of include symlinks failed."

	dodir /etc/init.d
	exeinto /etc/init.d

	doexe ${FILESDIR}/heimdal-kdc \
		${FILESDIR}/heimdal-kadmind \
		${FILESDIR}/heimdal-kpasswdd

	insinto /etc
		newins ${FILESDIR}/krb5.conf krb5.conf

	if use ldap;
	then
		insinto /etc/openldap/schema
		newins ${FILESDIR}/krb5-kdc.schema krb5-kdc.schema
	fi


	# default database dir
	dodir /var/heimdal

}

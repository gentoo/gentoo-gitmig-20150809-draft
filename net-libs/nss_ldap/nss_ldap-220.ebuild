# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/nss_ldap/nss_ldap-220.ebuild,v 1.3 2004/09/19 22:28:47 kloeri Exp $

inherit fixheadtails eutils gnuconfig

IUSE="berkdb debug"

DESCRIPTION="NSS LDAP Module"
HOMEPAGE="http://www.padl.com/OSS/nss_ldap.html"
SRC_URI="http://www.padl.com/download/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~hppa ~alpha"

DEPEND=">=net-nds/openldap-1.2.11
	berkdb? ( >=sys-libs/db-3 )"

src_unpack() {
	unpack ${A}
	# bug #34717
	EPATCH_OPTS="-d${S} -p1" epatch ${FILESDIR}/${PN}-220-db4.2-patch.diff
	cd ${S}
	epatch ${FILESDIR}/nsswitch.ldap.diff

	aclocal || die "aclocal failed"
	autoheader || die "autoheader failed"
	automake || die "automake failed"
	autoconf || die "autoconf failed"

	# fix head/tail stuff
	ht_fix_file ${S}/Makefile.am ${S}/Makefile.in ${S}/depcomp
	# update config.{guess,sub}
	gnuconfig_update
}

src_compile() {
	local myconf=""
	use berkdb && myconf="${myconf} --enable-rfc2307bis"
	use debug && myconf="${myconf} --enable-debugging"

	econf \
		--with-ldap-lib=openldap \
		--libdir=/lib \
		--enable-schema-mapping \
		--enable-paged-results \
		${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	dodir /lib

	make DESTDIR=${D} install || die "make install failed"

	insinto /etc
	doins ldap.conf

	dodoc ldap.conf ANNOUNCE NEWS ChangeLog AUTHORS \
		COPYING CVSVersionInfo.txt README nsswitch.ldap certutil
	docinto docs; dodoc doc/*
}

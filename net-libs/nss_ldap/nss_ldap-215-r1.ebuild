# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/nss_ldap/nss_ldap-215-r1.ebuild,v 1.2 2004/03/30 01:11:02 pylon Exp $

inherit fixheadtails

IUSE="berkdb debug"

DESCRIPTION="NSS LDAP Module"
HOMEPAGE="http://www.padl.com/OSS/nss_ldap.html"
SRC_URI="http://www.padl.com/download/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~sparc amd64 ~ppc"

DEPEND=">=net-nds/openldap-1.2.11
	berkdb? ( >=sys-libs/db-3 )"

src_unpack() {
	unpack ${A}
	# bug #34717
	epatch ${FILESDIR}/db4_1.85.diff
}

src_compile() {
	aclocal || die "aclocal failed"
	autoheader || die "autoheader failed"
	automake || die "automake failed"
	autoconf || die "autoconf failed"

	# fix head/tail stuff
	ht_fix_file ${S}/Makefile.am ${S}/Makefile.in ${S}/depcomp ${S}/config.guess

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
		COPYING CVSVersionInfo.txt README nsswitch.ldap \
		LICENSE*
	docinto docs; dodoc doc/*
}

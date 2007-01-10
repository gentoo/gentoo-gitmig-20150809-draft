# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_kerb/mod_auth_kerb-5.0_rc7-r1.ebuild,v 1.2 2007/01/10 21:59:54 phreak Exp $

MY_PV="${PV/_rc/rc}"

inherit eutils apache-module autotools

WANT_AUTOMAKE="1.9"
WANT_AUTOCONF="2.6"

DESCRIPTION="An Apache2 authentication DSO using Kerberos."
HOMEPAGE="http://modauthkerb.sourceforge.net/"
SRC_URI="mirror://sourceforge/modauthkerb/${PN}-${MY_PV}.tar.gz"

LICENSE="as-is"
KEYWORDS="~x86"
IUSE="apache2"
SLOT="0"

DEPEND="virtual/krb5"
RDEPEND=""

APACHE1_MOD_CONF="11_${PN}"
APACHE1_MOD_DEFINE="AUTH_KERB"

APACHE2_MOD_CONF="11_${PN}"
APACHE2_MOD_DEFINE="AUTH_KERB"

DOCFILES="INSTALL README"

need_apache

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-5.0-CVE-2006-5989.patch"
	epatch "${FILESDIR}/${PN}-5.0-gcc4.patch"
	if use apache2 ; then
		epatch "${FILESDIR}/${PN}-5.0-axps1.patch"
		epatch "${FILESDIR}/${PN}-5.0-cache.patch"
		epatch "${FILESDIR}/${PN}-5.0-exports.patch"
	fi

	eautoreconf
}

src_compile() {
	if use apache2 ; then
		CFLAGS="" APXS="${APXS2}" econf --with-krb5=/usr --without-krb4 || die "econf failed"
	else
		CFLAGS="" APXS="${APXS}" econf --with-krb5=/usr --without-krb4 || die "econf failed"
	fi
	emake || die "make failed"
}

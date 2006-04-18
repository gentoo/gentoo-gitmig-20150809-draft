# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_kerb/mod_auth_kerb-5.0_rc7.ebuild,v 1.1 2006/04/18 16:31:11 vericgar Exp $

MY_PV=${PV/_rc/rc}

inherit eutils apache-module

DESCRIPTION="An Apache2 authentication DSO using Kerberos"
HOMEPAGE="http://modauthkerb.sourceforge.net/"
SRC_URI="mirror://sourceforge/modauthkerb/${PN}-${MY_PV}.tar.gz"

LICENSE="as-is"
KEYWORDS="~x86"
IUSE="apache2"
SLOT="0"

DEPEND="app-crypt/mit-krb5"
RDEPEND=""

APACHE1_MOD_CONF="4.11-r1/11_${PN}"
APACHE1_MOD_DEFINE="AUTH_KERB"

APACHE2_MOD_CONF="4.11-r1/11_${PN}"
APACHE2_MOD_DEFINE="AUTH_KERB"

DOCFILES="INSTALL README"

need_apache

S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
	if use apache2; then
	    CFLAGS="" APXS="${APXS2}" econf --with-krb5=/usr --without-krb4 || die "econf failed"
	else
	    CFLAGS="" APXS="${APXS}" econf --with-krb5=/usr --without-krb4 || die "econf failed"
	fi
	emake || die "make failed"
}

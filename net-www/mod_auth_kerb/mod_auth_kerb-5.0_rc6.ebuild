# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_kerb/mod_auth_kerb-5.0_rc6.ebuild,v 1.1 2005/01/30 15:18:40 hollow Exp $

MY_PV=${PV/_rc/-rc}

inherit eutils apache-module

DESCRIPTION="An Apache2 authentication DSO using Kerberos"
HOMEPAGE="http://modauthkerb.sourceforge.net/"
SRC_URI="mirror://sourceforge/modauthkerb/${PN}-${MY_PV}.tar.gz"

LICENSE="as-is"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

S="${WORKDIR}/${PN}-${MY_PV}"
DEPEND="app-crypt/mit-krb5"
RDEPEND=""

APACHE2_MOD_CONF="4.11-r1/11_${PN}"
APACHE2_MOD_DEFINE="AUTH_KERB"

DOCFILES="INSTALL README"

need_apache2

src_compile() {
	CFLAGS="" APXS="${APXS2}" econf --with-krb5=/usr --without-krb4 || die "econf failed"
	emake
}

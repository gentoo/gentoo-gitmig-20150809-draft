# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_kerb/mod_auth_kerb-5.3.ebuild,v 1.3 2007/01/15 20:17:07 chtekk Exp $

inherit apache-module

KEYWORDS="x86"

DESCRIPTION="An Apache authentication module using Kerberos."
HOMEPAGE="http://modauthkerb.sourceforge.net/"
SRC_URI="mirror://sourceforge/modauthkerb/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
IUSE=""

DEPEND="virtual/krb5"
RDEPEND="${DEPEND}"

APACHE1_MOD_CONF="11_${PN}"
APACHE1_MOD_DEFINE="AUTH_KERB"

APACHE2_MOD_CONF="11_${PN}"
APACHE2_MOD_DEFINE="AUTH_KERB"

DOCFILES="INSTALL README"

need_apache

src_compile() {
	if use apache2 ; then
		CFLAGS="" APXS="${APXS2}" econf --with-krb5=/usr --without-krb4 || die "econf failed"
	else
		CFLAGS="" APXS="${APXS}" econf --with-krb5=/usr --without-krb4 || die "econf failed"
	fi
	emake || die "emake failed"
}

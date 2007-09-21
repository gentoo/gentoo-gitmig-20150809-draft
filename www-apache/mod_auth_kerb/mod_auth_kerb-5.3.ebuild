# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_auth_kerb/mod_auth_kerb-5.3.ebuild,v 1.2 2007/09/21 20:59:36 hollow Exp $

inherit apache-module

DESCRIPTION="An Apache authentication module using Kerberos."
HOMEPAGE="http://modauthkerb.sourceforge.net/"
SRC_URI="mirror://sourceforge/modauthkerb/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/krb5"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="11_${PN}"
APACHE2_MOD_DEFINE="AUTH_KERB"

DOCFILES="INSTALL README"

need_apache

src_compile() {
	CFLAGS="" APXS="${APXS2}" econf --with-krb5=/usr --without-krb4 || die "econf failed"
	emake || die "emake failed"
}

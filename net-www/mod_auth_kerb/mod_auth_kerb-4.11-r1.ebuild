# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_kerb/mod_auth_kerb-4.11-r1.ebuild,v 1.1 2005/01/09 00:38:29 hollow Exp $

inherit eutils apache-module

DESCRIPTION="An Apache2 authentication DSO using Kerberos"
HOMEPAGE="http://modauthkerb.sourceforge.net/"

S=${WORKDIR}/src
SRC_URI="mirror://sourceforge/modauthkerb/${P}.tar.gz"
DEPEND="app-crypt/mit-krb5 =net-www/apache-2*"
RDEPEND=""
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE=""
SLOT="0"
APXS2_S=${S}/modules/kerberos
APXS2_ARGS="-DAPXS2 -DKRB5 -DKRB5_SAVE_CREDENTIALS -DKRB_DEF_REALM=\\\"EOS.NCSU.EDU\\\" -ldl -lkrb5 -lcom_err -lk5crypto -c ${PN}.c"
APACHE2_MOD_CONF="${PVR}/11_mod_auth_kerb"

src_unpack() {
	unpack ${A} || die; cd ${S} || die;
	epatch ${FILESDIR}/mod_auth_kerb_register.patch
}

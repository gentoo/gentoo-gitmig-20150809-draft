# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_kerb/mod_auth_kerb-4.11.ebuild,v 1.5 2004/04/04 22:22:17 zul Exp $

inherit eutils

DESCRIPTION="An Apache2 authentication DSO using Kerberos"
HOMEPAGE="http://modauthkerb.sourceforge.net/"

S=${WORKDIR}/src
SRC_URI="mirror://sourceforge/modauthkerb/${P}.tar.gz"
DEPEND="app-crypt/mit-krb5 =net-www/apache-2*"
LICENSE="Apache-1.1"
KEYWORDS="x86"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A} || die; cd ${S} || die;
	epatch ${FILESDIR}/mod_auth_kerb_register.patch
}

src_compile() {
	cd modules/kerberos
	apxs2 -DAPXS2 -DKRB5 -DKRB5_SAVE_CREDENTIALS \
		-DKRB_DEF_REALM=\\\"EOS.NCSU.EDU\\\" \
		-ldl -lkrb5 -lcom_err -lk5crypto -c ${PN}.c || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe modules/kerberos/.libs/${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/11_mod_auth_kerb.conf
	dodoc ${FILESDIR}/11_mod_auth_kerb.conf
	#thats all the docs there is right now!
}

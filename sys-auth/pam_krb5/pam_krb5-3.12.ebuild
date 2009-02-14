# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_krb5/pam_krb5-3.12.ebuild,v 1.4 2009/02/14 16:33:54 armin76 Exp $

inherit multilib eutils pam

DESCRIPTION="Kerberos 5 PAM Authentication Module"
HOMEPAGE="http://www.eyrie.org/~eagle/software/pam-krb5/"
SRC_URI="http://archives.eyrie.org/software/ARCHIVE/pam-krb5/pam-krb5-${PV}.tar.gz"

LICENSE="|| ( BSD-2 GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc"

DEPEND="virtual/krb5"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P/_/-}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-CVE-2009-0361-0362.patch"
}

src_compile() {
	econf \
		  --libdir=/$(get_libdir)\
		  || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	newpammod pam_krb5.so pam_krb5.so
	if use doc; then
		doman pam_krb5.5
		dodoc CHANGES CHANGES-old NEWS README TODO
	fi;
}

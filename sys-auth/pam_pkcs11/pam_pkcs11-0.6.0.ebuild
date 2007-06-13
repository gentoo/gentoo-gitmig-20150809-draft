# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_pkcs11/pam_pkcs11-0.6.0.ebuild,v 1.1 2007/06/13 10:08:55 alonbl Exp $

inherit eutils

DESCRIPTION="PKCS11 Pam library"
HOMEPAGE="http://www.opensc-project.org/pam_pkcs11"
SRC_URI="http://www.opensc-project.org/files/pam_pkcs11/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="curl ldap pcsc-lite"

DEPEND="
	sys-libs/pam
	curl? ( net-misc/curl )
	ldap? ( net-nds/openldap )
	pcsc-lite? ( sys-apps/pcsc-lite )
	dev-libs/openssl"

src_compile() {
		econf \
			$(use_with curl) \
			$(use_with pcsc-lite pcsclite) \
			$(use_with ldap) \
			|| die "econf failed"

		emake || die "emake failed"
}

src_install() {
		make DESTDIR="${D}" install || die "install failed"

		dodir /lib/security
		dosym ../../usr/lib/security/pam_pkcs11.so /lib/security/

		dodoc NEWS README
}

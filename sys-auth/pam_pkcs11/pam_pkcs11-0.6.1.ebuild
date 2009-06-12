# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_pkcs11/pam_pkcs11-0.6.1.ebuild,v 1.1 2009/06/12 14:57:31 arfrever Exp $

inherit multilib

DESCRIPTION="PKCS11 Pam library"
HOMEPAGE="http://www.opensc-project.org/pam_pkcs11"
SRC_URI="http://www.opensc-project.org/files/pam_pkcs11/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="curl ldap pcsc-lite"

RDEPEND="sys-libs/pam
	dev-libs/openssl
	curl? ( net-misc/curl )
	ldap? ( net-nds/openldap )
	pcsc-lite? ( sys-apps/pcsc-lite )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
		$(use_with curl) \
		$(use_with pcsc-lite pcsclite) \
		$(use_with ldap)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodir /$(get_libdir)/security
	dosym ../../usr/$(get_libdir)/security/pam_pkcs11.so /$(get_libdir)/security/

	dodoc NEWS README
}

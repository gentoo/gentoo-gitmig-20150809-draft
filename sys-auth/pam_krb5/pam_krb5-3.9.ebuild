# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_krb5/pam_krb5-3.9.ebuild,v 1.1 2007/12/04 16:44:30 cardoe Exp $

inherit multilib eutils

DESCRIPTION="Kerberos 5 PAM Authentication Module"
HOMEPAGE="http://www.eyrie.org/~eagle/software/pam-krb5/"
SRC_URI="http://archives.eyrie.org/software/kerberos/pam-krb5-${PV}.tar.gz"

LICENSE="|| ( BSD-2 GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/krb5"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P/_/-}"

src_compile() {
	cd "${S}"
	econf --libdir=/$(get_libdir) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install
}

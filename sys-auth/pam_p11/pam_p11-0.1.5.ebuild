# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_p11/pam_p11-0.1.5.ebuild,v 1.9 2010/10/30 19:52:16 flameeyes Exp $

inherit pam

DESCRIPTION="PAM module for authenticating against PKCS#11 tokens"
HOMEPAGE="http://www.opensc-project.org/pam_p11/"
SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/pam
		dev-libs/libp11
		dev-libs/openssl"
RDEPEND="${DEPEND}"

src_install() {
	dopammod src/.libs/pam_p11_opensc.so
	dopammod src/.libs/pam_p11_openssh.so

	dohtml doc/*.html doc/*.css
}

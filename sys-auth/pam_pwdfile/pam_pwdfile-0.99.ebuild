# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_pwdfile/pam_pwdfile-0.99.ebuild,v 1.2 2006/01/02 05:34:52 halcy0n Exp $

inherit flag-o-matic

DESCRIPTION="PAM module for authenticating against passwd-like files."
HOMEPAGE="http://cpbotha.net/pam_pwdfile.html"
SRC_URI="http://cpbotha.net/files/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""
DEPEND="sys-libs/pam"

src_compile() {
	# the upstream makefile does CFLAGS in a horrible way
	# that '-c' is 100% required here
	append-flags -fPIC -Wall -Wformat-security -D_BSD_SOURCE -c
	emake -f contrib/Makefile.standalone CFLAGS="${CFLAGS}"
}

src_install() {
	exeinto /lib/security
	doexe ${PN}.so
	dodoc INSTALL README changelog contrib/warwick_duncan-cyrus_without_system_accounts.txt
}

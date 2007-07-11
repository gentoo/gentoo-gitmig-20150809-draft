# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_passwdqc/pam_passwdqc-1.0.4.ebuild,v 1.1 2007/07/11 12:37:52 flameeyes Exp $

inherit pam eutils toolchain-funcs

DESCRIPTION="Password strength checking for PAM aware password changing programs"
HOMEPAGE="http://www.openwall.com/passwdqc/"
SRC_URI="http://www.openwall.com/pam/modules/pam_passwdqc/${P}.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"

DEPEND="virtual/pam"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake \
		OPTCFLAGS="${CFLAGS}" \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		|| die "emake failed"
}

src_install() {
	dopammod pam_passwdqc.so

	doman pam_passwdqc.8
	dodoc README PLATFORMS INTERNALS LICENSE
}

pkg_postinst() {
	elog
	elog "To activate pam_passwdqc use pam_passwdqc.so instead"
	elog "of pam_cracklib.so in /etc/pam.d/system-auth."
	elog "Also, if you want to change the parameters, read up"
	elog "on the pam_passwdqc(8) man page."
	elog
}

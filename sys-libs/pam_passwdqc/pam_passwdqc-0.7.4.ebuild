# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam_passwdqc/pam_passwdqc-0.7.4.ebuild,v 1.3 2004/02/17 08:12:42 mr_bones_ Exp $


DESCRIPTION="Password strength checking for PAM aware password changing programs"
HOMEPAGE="http://www.openwall.com/passwdqc/"
SRC_URI="http://www.openwall.com/pam/modules/pam_passwdqc/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips"

DEPEND=">=sys-libs/pam-0.72"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
}

src_compile() {
	emake || die "problem in compile"
}

src_install() {
	exeinto /lib/security
	doexe pam_passwdqc.so

	doman pam_passwdqc.8
	dodoc README

	echo
	einfo "To activate pam_passwdqc use pam_passwdqc.so instead"
	einfo "of pam_cracklib.so in /etc/pam.d/system-auth."
	einfo "Also, if you want to change the parameters, read up"
	einfo "on the man page."
	echo
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Auth/PEAR-Auth-1.5.4.ebuild,v 1.1 2007/08/20 21:22:58 jokey Exp $

inherit php-pear-r1 depend.php eutils

DESCRIPTION="Provides methods for creating an authentication system using PHP."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="minimal"
RDEPEND="!minimal? ( >=dev-php/PEAR-Log-1.9.10
		    >=dev-php/PEAR-File_Passwd-1.1.0
		    >=dev-php/PEAR-Net_POP3-1.3.0
		    >=dev-php/PEAR-DB-1.7.6-r1
		    dev-php/PEAR-MDB
		    >=dev-php/PEAR-MDB2-2.0.0_rc1
		    >=dev-php/PEAR-Crypt_CHAP-1.0.0
		    >=dev-php/PEAR-File_SMBPasswd-1.0.0
		    >=dev-php/PEAR-SOAP-0.9.0 )"
		    # missing lots of keywords
		    # >=dev-php/PEAR-HTTP_Client-1.1.0

pkg_postinst() {
	has_php
	if ! use minimal && ! built_with_use --missing true =${PHP_PKG} imap soap ; then
		elog "${PN} can optionally use ${PHP_PKG} imap and soap features."
		elog "If you want those, recompile ${PHP_PKG} with these flags in USE."
	fi
}

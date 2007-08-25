# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Log/PEAR-Log-1.9.11.ebuild,v 1.2 2007/08/25 23:19:17 vapier Exp $

inherit php-pear-r1 depend.php eutils

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

DESCRIPTION="The Log framework provides an abstracted logging system. It supports logging to console, file, syslog, SQL, Sqlite, mail, and mcal targets."
LICENSE="PHP"
SLOT="0"
IUSE="minimal"

RDEPEND="!minimal? ( >=dev-php/PEAR-DB-1.7.6-r1
	>=dev-php/PEAR-MDB2-2.0.0_rc1 )"

pkg_postinst() {
	has_php
	if ! use minimal && ! built_with_use --missing true =${PHP_PKG} sqlite ; then
		elog "${PN} can optionally use ${PHP_PKG} sqlite features."
		elog "If you want those, recompile ${PHP_PKG} with this flag in USE."
	fi
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Log/PEAR-Log-1.9.8.ebuild,v 1.1 2006/08/10 11:38:26 sebastian Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="The Log framework provides an abstracted logging system supporting logging to console, file, syslog, SQL, and mcal targets"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-DB-1.7.6-r1"

pkg_setup() {
	require_php_with_use sqlite
}

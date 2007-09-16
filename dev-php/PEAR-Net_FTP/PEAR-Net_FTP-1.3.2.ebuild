# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_FTP/PEAR-Net_FTP-1.3.2.ebuild,v 1.8 2007/09/16 06:31:28 jer Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Provides an OO interface to the PHP FTP functions"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use ftp
}

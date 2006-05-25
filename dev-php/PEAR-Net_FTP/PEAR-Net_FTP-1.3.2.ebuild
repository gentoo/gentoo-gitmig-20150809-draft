# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_FTP/PEAR-Net_FTP-1.3.2.ebuild,v 1.2 2006/05/25 18:54:04 nixnut Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Provides an OO interface to the PHP FTP functions."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use ftp
}

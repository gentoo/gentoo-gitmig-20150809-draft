# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-Database/ezc-Database-1.0.1.ebuild,v 1.1 2006/02/20 10:51:18 sebastian Exp $

inherit php-ezc depend.php

DESCRIPTION="This eZ component provides a lightweight database layer on top of PDO."
SLOT="0"
KEYWORDS="~x86"
IUSE=""

pkg_setup() {
	require_pdo
}

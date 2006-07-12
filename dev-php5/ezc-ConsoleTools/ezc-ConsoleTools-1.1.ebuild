# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-ConsoleTools/ezc-ConsoleTools-1.1.ebuild,v 1.2 2006/07/12 07:53:57 sebastian Exp $

inherit php-ezc depend.php

DESCRIPTION="This eZ component provides a set of classes to do different actions with the console."
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86 ~amd64"
IUSE=""

pkg_setup() {
	require_php_with_use spl
}

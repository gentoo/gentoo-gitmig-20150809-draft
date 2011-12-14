# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-ConsoleTools/ezc-ConsoleTools-1.6.1.ebuild,v 1.1 2011/12/14 22:04:54 mabi Exp $

EZC_BASE_MIN="1.8"
inherit php-ezc depend.php

DESCRIPTION="This eZ component provides a set of classes to do different actions with the console."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use spl
}

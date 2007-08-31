# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-Translation/ezc-Translation-1.1.4.ebuild,v 1.2 2007/08/31 15:06:17 jer Exp $

inherit php-ezc depend.php

DESCRIPTION="This eZ component reads XML translation definitions (the Qt Linguist format)
and presents you with a class to apply translations to strings."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use xml
}

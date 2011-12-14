# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-UserInput/ezc-UserInput-1.4.ebuild,v 1.1 2011/12/14 22:26:07 mabi Exp $

EZC_BASE_MIN="1.8"
inherit php-ezc depend.php

DESCRIPTION="This eZ component assists you to safely import user input variables into your application."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use filter
}

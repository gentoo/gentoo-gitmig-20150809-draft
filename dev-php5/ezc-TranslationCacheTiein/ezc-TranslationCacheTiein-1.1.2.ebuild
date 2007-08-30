# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-TranslationCacheTiein/ezc-TranslationCacheTiein-1.1.2.ebuild,v 1.1 2007/08/30 13:57:11 jokey Exp $

inherit php-ezc depend.php

DESCRIPTION="This eZ component adds the TranslationCache backend to the Translation component."
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php5/ezc-Translation-1.1.4
	>=dev-php5/ezc-Cache-1.2"

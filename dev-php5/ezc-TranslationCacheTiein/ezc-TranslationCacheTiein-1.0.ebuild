# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-TranslationCacheTiein/ezc-TranslationCacheTiein-1.0.ebuild,v 1.2 2006/05/30 11:16:20 corsair Exp $

inherit php-ezc

DESCRIPTION="This eZ component adds the TranslationCache backend to the Translation component."
SLOT="0"
KEYWORDS="~ppc64 ~x86"
IUSE=""
RDEPEND="${RDEPEND}
	dev-php5/ezc-Cache
	dev-php5/ezc-Translation"

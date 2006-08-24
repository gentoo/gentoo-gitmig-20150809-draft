# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-TranslationCacheTiein/ezc-TranslationCacheTiein-1.1.ebuild,v 1.3 2006/08/24 02:11:13 weeve Exp $

inherit php-ezc

DESCRIPTION="This eZ component adds the TranslationCache backend to the Translation component."
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND="${RDEPEND}
	dev-php5/ezc-Cache
	dev-php5/ezc-Translation"

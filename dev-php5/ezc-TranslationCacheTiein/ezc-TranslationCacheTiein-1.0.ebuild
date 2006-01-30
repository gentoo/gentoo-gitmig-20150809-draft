# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-TranslationCacheTiein/ezc-TranslationCacheTiein-1.0.ebuild,v 1.1 2006/01/30 15:30:31 sebastian Exp $

inherit php-ezc

DESCRIPTION="This eZ component adds the TranslationCache backend to the Translation component."
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="${RDEPEND}
	dev-php5/ezc-Cache
	dev-php5/ezc-Translation"

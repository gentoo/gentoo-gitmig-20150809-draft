# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-en/aspell-en-6.0.0.ebuild,v 1.2 2004/10/05 00:06:23 eradicator Exp $

ASPELL_LANG="English (US, British, Canadian)"

LICENSE="as-is public-domain"
ASPOSTFIX="6"

inherit aspell-dict

# as this depends on aspell 0.6 we need to change the KEYWORDS
KEYWORDS="~amd64 ~sparc ~x86"

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-he/aspell-he-0.8.0.ebuild,v 1.2 2004/10/05 00:40:07 arj Exp $

ASPELL_LANG="Hebrew"

LICENSE="GPL-2"
ASPOSTFIX="6"

inherit aspell-dict

# as this depends on aspell 0.6 we need to change the KEYWORDS
KEYWORDS="~amd64 ~sparc ~x86"

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-he/aspell-he-0.9.0.ebuild,v 1.1 2005/02/15 21:31:24 arj Exp $

ASPELL_LANG="Hebrew"

LICENSE="GPL-2"
ASPOSTFIX="6"

inherit aspell-dict

# as this depends on aspell 0.6 we need to change the KEYWORDS
KEYWORDS="~amd64 ~sparc ~x86 ~ppc"
IUSE=""

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-lt/aspell-lt-1.0.1.ebuild,v 1.3 2009/01/13 16:33:52 tcunha Exp $

ASPELL_LANG="Lithuanian"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

FILENAME="aspell6-lt-1.0-1"
SRC_URI="mirror://gnu/aspell/dict/lt/${FILENAME}.tar.bz2"

S="${WORKDIR}/${FILENAME}"

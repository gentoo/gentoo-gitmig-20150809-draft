# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-lt/aspell-lt-1.0.1.ebuild,v 1.2 2007/11/03 22:14:48 uberlord Exp $

ASPELL_LANG="Lithuanian"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~sparc-fbsd ~x86 ~x86-fbsd"

FILENAME="aspell6-lt-1.0-1"
SRC_URI="mirror://gnu/aspell/dict/lt/${FILENAME}.tar.bz2"

S="${WORKDIR}/${FILENAME}"

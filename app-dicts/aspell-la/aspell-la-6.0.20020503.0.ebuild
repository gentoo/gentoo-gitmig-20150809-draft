# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-la/aspell-la-6.0.20020503.0.ebuild,v 1.1 2007/08/18 18:09:25 philantrop Exp $

ASPELL_LANG="Latin"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~ppc ~x86"

FILENAME="aspell6-la-20020503-0"
SRC_URI="mirror://gnu/aspell/dict/la/${FILENAME}.tar.bz2"

S=${WORKDIR}/${FILENAME}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-hy/aspell-hy-0.10.0.ebuild,v 1.1 2007/09/02 09:07:24 philantrop Exp $

ASPELL_LANG="Armenian"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"

FILENAME=aspell6-hy-0.10.0-0
SRC_URI="mirror://gnu/aspell/dict/hy/${FILENAME}.tar.bz2"

S="${WORKDIR}/${FILENAME}"

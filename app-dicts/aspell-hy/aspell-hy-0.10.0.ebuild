# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-hy/aspell-hy-0.10.0.ebuild,v 1.5 2010/03/07 18:05:41 armin76 Exp $

ASPELL_LANG="Armenian"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

FILENAME=aspell6-hy-0.10.0-0
SRC_URI="mirror://gnu/aspell/dict/hy/${FILENAME}.tar.bz2"

S="${WORKDIR}/${FILENAME}"

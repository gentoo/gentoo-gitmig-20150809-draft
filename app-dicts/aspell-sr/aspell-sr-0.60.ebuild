# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-sr/aspell-sr-0.60.ebuild,v 1.3 2007/01/02 04:06:28 vapier Exp $

ASPELL_LANG="Serbian"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

FILENAME="aspell6-sr-0.02"
SRC_URI="http://srpski.org/aspell/${FILENAME}.tar.bz2"
S=${WORKDIR}/${FILENAME}
RESTRICT="nomirror"

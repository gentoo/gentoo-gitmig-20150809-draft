# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-es/aspell-es-1.9a.ebuild,v 1.9 2010/06/05 15:37:10 armin76 Exp $

ASPELL_LANG="Spanish"
ASPOSTFIX="6"

inherit aspell-dict

MY_P="${P/aspell/aspell6}-1"
S=${WORKDIR}/${MY_P}
SRC_URI="mirror://gnu/aspell/dict/${SPELLANG}/${MY_P}.tar.bz2"

LICENSE="GPL-2"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

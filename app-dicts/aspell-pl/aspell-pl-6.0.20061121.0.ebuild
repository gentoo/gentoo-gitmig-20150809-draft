# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-pl/aspell-pl-6.0.20061121.0.ebuild,v 1.8 2007/08/25 11:55:32 vapier Exp $

ASPELL_LANG="Polish"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"

FILENAME="aspell6-pl-6.0_20061121-0"
SRC_URI="mirror://gnu/aspell/dict/pl/${FILENAME}.tar.bz2"
S=${WORKDIR}/${FILENAME}

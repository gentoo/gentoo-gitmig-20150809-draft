# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-it/aspell-it-2.2.20050523.ebuild,v 1.17 2012/03/17 23:04:49 mattst88 Exp $

ASPELL_LANG="Italian"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

FILENAME="aspell6-it-2.2_20050523-0"
SRC_URI="mirror://gnu/aspell/dict/it/${FILENAME}.tar.bz2"
S=${WORKDIR}/${FILENAME}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-de/aspell-de-0.60_pre20030222.ebuild,v 1.19 2010/01/01 20:03:27 fauli Exp $

ASPELL_LANG="German and Swiss-German"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-macos"
IUSE=""

FILENAME=aspell6-de-20030222-1

SRC_URI="mirror://gnu/aspell/dict/de/${FILENAME}.tar.bz2"
S=${WORKDIR}/${FILENAME}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-hu/aspell-hu-0.99.4.2.ebuild,v 1.7 2010/03/21 14:55:06 ranger Exp $

ASPELL_LANG="Hungarian"
APOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc64 ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

FILENAME="aspell6-hu-0.99.4.2-0"
SRC_URI="mirror://gnu/aspell/dict/hu/${FILENAME}.tar.bz2"

S="${WORKDIR}/${FILENAME}"

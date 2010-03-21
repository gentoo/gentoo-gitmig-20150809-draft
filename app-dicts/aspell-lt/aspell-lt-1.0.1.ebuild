# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-lt/aspell-lt-1.0.1.ebuild,v 1.10 2010/03/21 14:51:15 ranger Exp $

ASPELL_LANG="Lithuanian"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"

FILENAME="aspell6-lt-1.0-1"
SRC_URI="mirror://gnu/aspell/dict/lt/${FILENAME}.tar.bz2"
IUSE=""

S="${WORKDIR}/${FILENAME}"

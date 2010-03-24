# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-eo/aspell-eo-2.1.20000225.2.ebuild,v 1.4 2010/03/24 15:56:26 ranger Exp $

ASPELL_LANG="Esperanto"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

MY_P=${P%.*}a-${PV##*.}
MY_P=aspell${ASPOSTFIX}-${MY_P/aspell-/}
S=${WORKDIR}/${MY_P}
SRC_URI="mirror://gnu/aspell/dict/${SPELLANG}/${MY_P}.tar.bz2"

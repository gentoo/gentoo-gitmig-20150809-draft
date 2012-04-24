# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-cs/myspell-cs-20110224.ebuild,v 1.1 2012/04/24 12:48:18 scarabeus Exp $

EAPI=4

MYSPELL_DICT=(
	"cs_CZ.dic"
	"cs_CZ.aff"
)

MYSPELL_HYPH=(
	"hyph_cs_CZ.dic"
)

MYSPELL_THES=(
	"th_cs_CZ_v3.dat"
	"th_cs_CZ_v3.idx"
)

inherit myspell-r2

DESCRIPTION="Czech dictionaries for myspell/hunspell"
HOMEPAGE="http://www.liberix.cz/doplnky/slovniky/ooo/"
SRC_URI="${HOMEPAGE}/dict-cs-2.oxt -> ${P}.zip"

LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

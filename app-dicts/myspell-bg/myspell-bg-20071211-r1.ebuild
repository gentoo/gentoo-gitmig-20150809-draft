# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-bg/myspell-bg-20071211-r1.ebuild,v 1.4 2011/12/14 08:50:20 phajdan.jr Exp $

# 20071211 is a 4.1 version from sf.net released on 20071211

MYSPELL_SPELLING_DICTIONARIES=(
"bg,BG,bg_BG,Bulgarian (Bulgaria),bg_BG.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"bg,BG,hyph_bg_BG,Bulgarian (Bulgaria),hyph_bg_BG.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"bg,BG,th_bg_BG,Bulgarian (Bulgaria),thes_bg_BG.zip"
)

inherit eutils myspell

DESCRIPTION="Bulgarian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://bgoffice.sourceforge.net/"

KEYWORDS="alpha ~amd64 arm ~hppa ia64 ~mips ~ppc ~ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	epatch "${FILESDIR}/myspell-bg-20071211-encoding.patch"
}

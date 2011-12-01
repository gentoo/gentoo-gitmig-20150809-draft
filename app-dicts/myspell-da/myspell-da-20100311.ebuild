# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-da/myspell-da-20100311.ebuild,v 1.6 2011/12/01 19:49:09 phajdan.jr Exp $

# 1.7.32 version from http://da.speling.org/filer/
# Hyphenation dates hyph_da_DK.zip from 2007-09-03 :
# http://wiki.services.openoffice.org/wiki/Dictionaries#Danish_.28Denmark.29

MYSPELL_SPELLING_DICTIONARIES=(
"da,DK,da_DK,Danish (Denmark),da_DK.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"da,DK,hyph_da_DK,Danish (Denmark),hyph_da_DK.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Danish dictionaries for myspell/hunspell"
LICENSE="GPL-2 LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://da.speling.org/"

KEYWORDS="alpha ~amd64 arm ~hppa ia64 ~mips ~ppc ~ppc64 sh sparc x86 ~x86-fbsd ~x86-macos"
IUSE=""

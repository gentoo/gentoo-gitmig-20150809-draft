# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-fr/myspell-fr-20060316.ebuild,v 1.18 2010/07/02 10:23:19 grobian Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"fr,BE,fr_FR,French (Belgium),fr_FR.zip"
"fr,CA,fr_FR,French (Canada),fr_FR.zip"
"fr,FR,fr_FR,French (France),fr_FR.zip"
"fr,LU,fr_FR,French (Luxembourg),fr_FR.zip"
"fr,MC,fr_FR,French (Monaco),fr_FR.zip"
"fr,CH,fr_FR,French (Switzerland),fr_FR.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"fr,BE,hyph_fr_FR,French (Belgium),hyph_fr_FR.zip"
"fr,CA,hyph_fr_FR,French (Canada),hyph_fr_FR.zip"
"fr,FR,hyph_fr_FR,French (France),hyph_fr_FR.zip"
"fr,LU,hyph_fr_FR,French (Luxembourg),hyph_fr_FR.zip"
"fr,MC,hyph_fr_FR,French (Monaco),hyph_fr_FR.zip"
"fr,CH,hyph_fr_FR,French (Switzerland),hyph_fr_FR.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"fr,BE,th_fr_FR,French (Belgium),thes_fr_FR.zip"
"fr,CA,th_fr_FR,French (Canada),thes_fr_FR.zip"
"fr,FR,th_fr_FR,French (France),thes_fr_FR.zip"
"fr,LU,th_fr_FR,French (Luxembourg),thes_fr_FR.zip"
"fr,MC,th_fr_FR,French (Monaco),thes_fr_FR.zip"
"fr,CH,th_fr_FR,French (Switzerland),thes_fr_FR.zip"
)

inherit myspell

DESCRIPTION="French dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/"
IUSE=""

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-macos"

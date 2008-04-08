# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-german/texlive-documentation-german-2007.ebuild,v 1.13 2008/04/08 14:59:13 armin76 Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="FAQ-ge kopka l2picfaq l2tabu latex-tipps-und-tricks lshort-german texlive-ge voss-de collection-documentation-german
"
inherit texlive-module
DESCRIPTION="TeXLive German documentation"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"

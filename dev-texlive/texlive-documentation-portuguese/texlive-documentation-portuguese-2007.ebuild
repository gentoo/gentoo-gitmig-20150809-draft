# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-portuguese/texlive-documentation-portuguese-2007.ebuild,v 1.2 2007/10/25 06:35:34 opfer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="beamer-tut-pt cursolatex lshort-portuguese xypic-tut-pt collection-documentation-portuguese
"
inherit texlive-module
DESCRIPTION="TeXLive Portuguese documentation"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~x86"

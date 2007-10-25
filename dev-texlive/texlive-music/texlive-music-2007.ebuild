# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-music/texlive-music-2007.ebuild,v 1.2 2007/10/25 08:16:17 opfer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-latex
"
TEXLIVE_MODULE_CONTENTS="abc bin-musixflx guitar musictex musixlyr musixps musixtex songbook collection-music
"
inherit texlive-module
DESCRIPTION="TeXLive Music typesetting"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~x86"

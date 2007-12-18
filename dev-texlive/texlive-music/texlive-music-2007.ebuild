# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-music/texlive-music-2007.ebuild,v 1.7 2007/12/18 19:47:41 jer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-latex
"
TEXLIVE_MODULE_CONTENTS="abc bin-musixflx guitar musictex musixlyr musixps musixtex songbook collection-music
"
inherit texlive-module
DESCRIPTION="TeXLive Music typesetting"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86"

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-context/texlive-context-2007.ebuild,v 1.3 2007/10/25 08:12:46 opfer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
dev-texlive/texlive-langgreek
dev-texlive/texlive-metapost"
TEXLIVE_MODULE_CONTENTS="bin-context context jmn lmextra collection-context
"
inherit texlive-module
DESCRIPTION="TeXLive ConTeXt format"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~x86"

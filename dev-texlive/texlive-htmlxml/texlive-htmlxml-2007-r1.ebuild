# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-htmlxml/texlive-htmlxml-2007-r1.ebuild,v 1.3 2007/10/25 12:54:57 fmccor Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
dev-texlive/texlive-fontsrecommended
dev-texlive/texlive-latex
>=app-text/jadetex-3.13-r2
"
TEXLIVE_MODULE_CONTENTS="bin-tex4htk bin-xmltex passivetex tex4ht xmlplay xmltex collection-htmlxml
"
inherit texlive-module
DESCRIPTION="TeXLive HTML/SGML/XML support"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~sparc ~x86"

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-htmlxml/texlive-htmlxml-2007-r2.ebuild,v 1.1 2007/10/30 18:06:07 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
dev-texlive/texlive-fontsrecommended
dev-texlive/texlive-latex
>=app-text/jadetex-3.13-r2
>=dev-tex/tex4ht-20071024
"
TEXLIVE_MODULE_CONTENTS="bin-xmltex passivetex xmlplay xmltex collection-htmlxml
"
inherit texlive-module
DESCRIPTION="TeXLive HTML/SGML/XML support"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-htmlxml/texlive-htmlxml-2007-r2.ebuild,v 1.13 2008/05/12 20:10:22 nixnut Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
dev-texlive/texlive-fontsrecommended
dev-texlive/texlive-latex
"
TEXLIVE_MODULE_CONTENTS="bin-xmltex passivetex xmlplay xmltex collection-htmlxml
"
inherit texlive-module
DESCRIPTION="TeXLive HTML/SGML/XML support"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"

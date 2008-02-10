# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langczechslovak/texlive-langczechslovak-2007.ebuild,v 1.8 2008/02/10 15:25:33 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
dev-texlive/texlive-latex
"
TEXLIVE_MODULE_CONTENTS="bin-cslatex bin-csplain bin-vlna cs cslatex csplain hyphen-czechslovak collection-langczechslovak
"
inherit texlive-module
DESCRIPTION="TeXLive Czech/Slovak"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86 ~x86-fbsd"

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-context/texlive-context-2007.ebuild,v 1.8 2007/12/18 19:58:26 jer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
dev-texlive/texlive-langgreek
dev-texlive/texlive-metapost"
TEXLIVE_MODULE_CONTENTS="bin-context context jmn lmextra collection-context
"
inherit texlive-module
DESCRIPTION="TeXLive ConTeXt format"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86"

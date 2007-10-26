# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langportuguese/texlive-langportuguese-2007.ebuild,v 1.6 2007/10/26 19:22:04 fmccor Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="hyphen-portuguese ordinalpt collection-langportuguese
"
inherit texlive-module
DESCRIPTION="TeXLive Portuguese"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"

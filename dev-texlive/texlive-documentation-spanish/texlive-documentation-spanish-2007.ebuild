# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-spanish/texlive-documentation-spanish-2007.ebuild,v 1.3 2007/10/25 12:45:49 fmccor Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="es-tex-faq lshort-spanish collection-documentation-spanish
"
inherit texlive-module
DESCRIPTION="TeXLive Spanish documentation"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~sparc ~x86"

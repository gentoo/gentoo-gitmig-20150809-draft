# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-genericextra/texlive-genericextra-2007.ebuild,v 1.6 2007/10/26 19:22:05 fmccor Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="abbr abstyles aurora barr borceux c-pascal colorsep dinat eijkhout fltpoint insbox mathdots metatex mftoeps midnight multi ofs pdf-trans psfig realcalc vrb vtex collection-genericextra
"
inherit texlive-module
DESCRIPTION="TeXLive Miscellaneous extra generic macros"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"

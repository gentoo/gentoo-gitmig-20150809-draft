# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-vietnamese/texlive-documentation-vietnamese-2007.ebuild,v 1.6 2007/10/26 19:22:07 fmccor Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="amsldoc-vn lshort-vietnamese ntheorem-vn collection-documentation-vietnamese
"
inherit texlive-module
DESCRIPTION="TeXLive Vietnamese documentation"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"

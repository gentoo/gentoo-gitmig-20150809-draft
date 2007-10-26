# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-french/texlive-documentation-french-2007.ebuild,v 1.6 2007/10/26 19:22:21 fmccor Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="FAQ-fr epslatex-fr impatient-fr l2tabu-french lshort-french texlive-fr collection-documentation-french
"
inherit texlive-module
DESCRIPTION="TeXLive French documentation"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"

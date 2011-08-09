# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-turkish/texlive-documentation-turkish-2010.ebuild,v 1.2 2011/08/09 21:09:10 hwoarang Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="lshort-turkish collection-documentation-turkish
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-turkish.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Turkish documentation"

LICENSE="GPL-2 public-domain "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2010
"
RDEPEND="${DEPEND} "

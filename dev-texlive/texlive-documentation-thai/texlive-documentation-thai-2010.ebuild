# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-thai/texlive-documentation-thai-2010.ebuild,v 1.2 2011/08/09 21:05:22 hwoarang Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="lshort-thai collection-documentation-thai
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-thai.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Thai documentation"

LICENSE="GPL-2 public-domain "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2010
"
RDEPEND="${DEPEND} "

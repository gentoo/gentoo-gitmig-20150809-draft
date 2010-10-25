# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-arabic/texlive-documentation-arabic-2010.ebuild,v 1.3 2010/10/25 12:03:42 fauli Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="lshort-persian collection-documentation-arabic
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-persian.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Arabic documentation"

LICENSE="GPL-2 public-domain "
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2010
"
RDEPEND="${DEPEND} "

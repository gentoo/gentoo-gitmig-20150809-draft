# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-base/texlive-documentation-base-2010.ebuild,v 1.2 2010/12/02 19:51:45 grobian Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="texlive-common texlive-docindex texlive-en collection-documentation-base
"
TEXLIVE_MODULE_DOC_CONTENTS="texlive-common.doc texlive-docindex.doc texlive-en.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive TeX Live documentation"

LICENSE="GPL-2 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~ppc-macos"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND} "

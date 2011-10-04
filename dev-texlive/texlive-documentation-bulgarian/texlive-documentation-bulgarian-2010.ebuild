# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-bulgarian/texlive-documentation-bulgarian-2010.ebuild,v 1.7 2011/10/04 18:06:52 jer Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="lshort-bulgarian pst-eucl-translation-bg collection-documentation-bulgarian
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-bulgarian.doc pst-eucl-translation-bg.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Bulgarian documentation"

LICENSE="GPL-2 FDL-1.1 public-domain "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2010
"
RDEPEND="${DEPEND} "

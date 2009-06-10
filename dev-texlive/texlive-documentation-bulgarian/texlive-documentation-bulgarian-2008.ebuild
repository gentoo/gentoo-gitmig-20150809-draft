# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-bulgarian/texlive-documentation-bulgarian-2008.ebuild,v 1.11 2009/06/10 13:56:14 alexxy Exp $

TEXLIVE_MODULE_CONTENTS="lshort-bulgarian collection-documentation-bulgarian
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-bulgarian.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Bulgarian documentation"

LICENSE="GPL-2 public-domain "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2008
"
RDEPEND="${DEPEND}"

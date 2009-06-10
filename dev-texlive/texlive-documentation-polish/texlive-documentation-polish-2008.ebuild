# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-polish/texlive-documentation-polish-2008.ebuild,v 1.11 2009/06/10 14:01:05 alexxy Exp $

TEXLIVE_MODULE_CONTENTS="guides-pl lshort-polish tex-virtual-academy-pl texlive-pl collection-documentation-polish
"
TEXLIVE_MODULE_DOC_CONTENTS="guides-pl.doc lshort-polish.doc tex-virtual-academy-pl.doc texlive-pl.doc "
TEXLIVE_MODULE_SRC_CONTENTS="texlive-pl.source "
inherit texlive-module
DESCRIPTION="TeXLive Polish documentation"

LICENSE="GPL-2 public-domain "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2008
"
RDEPEND="${DEPEND}"

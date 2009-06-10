# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-base/texlive-documentation-base-2008.ebuild,v 1.11 2009/06/10 13:55:50 alexxy Exp $

TEXLIVE_MODULE_CONTENTS="texlive-common texlive-en collection-documentation-base
"
TEXLIVE_MODULE_DOC_CONTENTS="texlive-en.doc "
TEXLIVE_MODULE_SRC_CONTENTS="texlive-common.source texlive-en.source "
inherit texlive-module
DESCRIPTION="TeXLive TeX Live documentation"

LICENSE="GPL-2 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

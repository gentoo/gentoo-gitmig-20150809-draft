# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langhungarian/texlive-langhungarian-2010.ebuild,v 1.7 2011/10/04 18:29:39 jer Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="magyar hyphen-hungarian collection-langhungarian
"
TEXLIVE_MODULE_DOC_CONTENTS="magyar.doc hyphen-hungarian.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Hungarian"

LICENSE="GPL-2 GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
"
RDEPEND="${DEPEND} "

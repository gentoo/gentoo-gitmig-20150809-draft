# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langmongolian/texlive-langmongolian-2008.ebuild,v 1.11 2009/06/10 14:14:40 alexxy Exp $

TEXLIVE_MODULE_CONTENTS="hyphen-mongolian mongolian-babel montex soyombo collection-langmongolian
"
TEXLIVE_MODULE_DOC_CONTENTS="mongolian-babel.doc montex.doc soyombo.doc "
TEXLIVE_MODULE_SRC_CONTENTS="mongolian-babel.source montex.source "
inherit texlive-module
DESCRIPTION="TeXLive Mongolian"

LICENSE="GPL-2 freedist GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2008
!=dev-texlive/texlive-langmanju-2007*
"
RDEPEND="${DEPEND}"

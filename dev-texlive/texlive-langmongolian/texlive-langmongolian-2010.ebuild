# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langmongolian/texlive-langmongolian-2010.ebuild,v 1.2 2011/08/09 21:26:34 hwoarang Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="hyphen-mongolian mongolian-babel montex soyombo collection-langmongolian
"
TEXLIVE_MODULE_DOC_CONTENTS="mongolian-babel.doc montex.doc soyombo.doc "
TEXLIVE_MODULE_SRC_CONTENTS="mongolian-babel.source "
inherit texlive-module
DESCRIPTION="TeXLive Mongolian"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
!=dev-texlive/texlive-langmanju-2007*
"
RDEPEND="${DEPEND} "

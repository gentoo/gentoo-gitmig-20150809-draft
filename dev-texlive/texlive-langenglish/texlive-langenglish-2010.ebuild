# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langenglish/texlive-langenglish-2010.ebuild,v 1.3 2010/10/25 12:05:10 fauli Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="hyphen-english collection-langenglish
"
TEXLIVE_MODULE_DOC_CONTENTS=""
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive US and UK English"

LICENSE="GPL-2 "
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
"
RDEPEND="${DEPEND} "

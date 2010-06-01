# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-luatex/texlive-luatex-2009.ebuild,v 1.10 2010/06/01 14:36:40 josejx Exp $

TEXLIVE_MODULE_CONTENTS="luainputenc luamplib luaotfload luatextra collection-luatex
"
TEXLIVE_MODULE_DOC_CONTENTS="luainputenc.doc luamplib.doc luaotfload.doc luatextra.doc "
TEXLIVE_MODULE_SRC_CONTENTS="luainputenc.source luamplib.source luaotfload.source luatextra.source "
inherit texlive-module
DESCRIPTION="TeXLive LuaTeX packages"

LICENSE="GPL-2 as-is public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2009
>=dev-tex/luatex-0.45

"
RDEPEND="${DEPEND} "

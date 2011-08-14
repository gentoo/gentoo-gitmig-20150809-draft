# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-luatex/texlive-luatex-2010-r1.ebuild,v 1.5 2011/08/14 18:12:43 maekke Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="luainputenc lualibs luamplib luaotfload luatexbase luatextra collection-luatex
"
TEXLIVE_MODULE_DOC_CONTENTS="luainputenc.doc lualibs.doc luamplib.doc luaotfload.doc luatexbase.doc luatextra.doc "
TEXLIVE_MODULE_SRC_CONTENTS="luainputenc.source lualibs.source luamplib.source luaotfload.source luatexbase.source luatextra.source "
inherit  texlive-module
DESCRIPTION="TeXLive LuaTeX packages"

LICENSE="GPL-2 GPL-2 public-domain "
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
>=dev-tex/luatex-0.45

"
RDEPEND="${DEPEND} "
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/luaotfload/mkluatexfontdb.lua"
PATCHES=( "${FILESDIR}/lualibs.patch" )

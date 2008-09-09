# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langtibetan/texlive-langtibetan-2008.ebuild,v 1.1 2008/09/09 16:44:16 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="ctib otibet collection-langtibetan
"
TEXLIVE_MODULE_DOC_CONTENTS="ctib.doc otibet.doc "
TEXLIVE_MODULE_SRC_CONTENTS="ctib.source otibet.source "
inherit texlive-module
DESCRIPTION="TeXLive Tibetan"

LICENSE="GPL-2 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

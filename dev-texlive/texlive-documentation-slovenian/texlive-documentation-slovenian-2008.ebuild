# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-slovenian/texlive-documentation-slovenian-2008.ebuild,v 1.5 2008/09/23 20:49:03 armin76 Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="lshort-slovenian collection-documentation-slovenian
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-slovenian.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Slovenian documentation"

LICENSE="GPL-2 GPL-1 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

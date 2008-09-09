# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-portuguese/texlive-documentation-portuguese-2008.ebuild,v 1.1 2008/09/09 16:22:14 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="beamer-tut-pt cursolatex lshort-portuguese xypic-tut-pt collection-documentation-portuguese
"
TEXLIVE_MODULE_DOC_CONTENTS="beamer-tut-pt.doc cursolatex.doc lshort-portuguese.doc xypic-tut-pt.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Portuguese documentation"

LICENSE="GPL-2 GPL-1 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

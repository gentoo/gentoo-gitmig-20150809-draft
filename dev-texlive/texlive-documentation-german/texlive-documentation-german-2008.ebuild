# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-german/texlive-documentation-german-2008.ebuild,v 1.1 2008/09/09 16:18:29 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="kopka l2picfaq l2tabu latex-tipps-und-tricks lshort-german pdf-forms-tutorial-de templates-fenn templates-sommer texlive-de voss-de collection-documentation-german
"
TEXLIVE_MODULE_DOC_CONTENTS="kopka.doc l2picfaq.doc l2tabu.doc latex-tipps-und-tricks.doc lshort-german.doc pdf-forms-tutorial-de.doc templates-fenn.doc templates-sommer.doc texlive-de.doc voss-de.doc "
TEXLIVE_MODULE_SRC_CONTENTS="texlive-de.source "
inherit texlive-module
DESCRIPTION="TeXLive German documentation"

LICENSE="GPL-2 as-is FDL-1.1 GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

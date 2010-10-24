# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-german/texlive-documentation-german-2010.ebuild,v 1.1 2010/10/24 18:11:53 aballier Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="kopka l2picfaq l2tabu latex-referenz latex-tabellen latex-tipps-und-tricks lshort-german pdf-forms-tutorial-de presentations templates-fenn templates-sommer texlive-de voss-de collection-documentation-german
"
TEXLIVE_MODULE_DOC_CONTENTS="kopka.doc l2picfaq.doc l2tabu.doc latex-referenz.doc latex-tabellen.doc latex-tipps-und-tricks.doc lshort-german.doc pdf-forms-tutorial-de.doc presentations.doc templates-fenn.doc templates-sommer.doc texlive-de.doc voss-de.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive German documentation"

LICENSE="GPL-2 as-is FDL-1.1 GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2010
"
RDEPEND="${DEPEND} "

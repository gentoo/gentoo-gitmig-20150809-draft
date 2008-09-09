# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-french/texlive-documentation-french-2008.ebuild,v 1.1 2008/09/09 16:17:56 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="epslatex-fr impatient-fr l2tabu-french lshort-french texlive-fr collection-documentation-french
"
TEXLIVE_MODULE_DOC_CONTENTS="epslatex-fr.doc impatient-fr.doc l2tabu-french.doc lshort-french.doc texlive-fr.doc "
TEXLIVE_MODULE_SRC_CONTENTS="texlive-fr.source "
inherit texlive-module
DESCRIPTION="TeXLive French documentation"

LICENSE="GPL-2 freedist GPL-1 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

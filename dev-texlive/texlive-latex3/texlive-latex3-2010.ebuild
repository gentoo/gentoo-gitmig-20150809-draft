# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-latex3/texlive-latex3-2010.ebuild,v 1.6 2011/09/18 17:30:07 armin76 Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="expl3 mh xpackages collection-latex3
"
TEXLIVE_MODULE_DOC_CONTENTS="expl3.doc mh.doc xpackages.doc "
TEXLIVE_MODULE_SRC_CONTENTS="expl3.source mh.source xpackages.source "
inherit texlive-module
DESCRIPTION="TeXLive LaTeX3 packages"

LICENSE="GPL-2 LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2010
!=dev-texlive/texlive-latexextra-2007*
"
RDEPEND="${DEPEND} "

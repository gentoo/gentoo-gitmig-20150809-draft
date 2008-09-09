# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-polish/texlive-documentation-polish-2008.ebuild,v 1.1 2008/09/09 16:21:42 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="guides-pl lshort-polish tex-virtual-academy-pl texlive-pl collection-documentation-polish
"
TEXLIVE_MODULE_DOC_CONTENTS="guides-pl.doc lshort-polish.doc tex-virtual-academy-pl.doc texlive-pl.doc "
TEXLIVE_MODULE_SRC_CONTENTS="texlive-pl.source "
inherit texlive-module
DESCRIPTION="TeXLive Polish documentation"

LICENSE="GPL-2 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

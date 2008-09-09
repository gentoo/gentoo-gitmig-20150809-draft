# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langafrican/texlive-langafrican-2008.ebuild,v 1.1 2008/09/09 16:30:46 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="ethiop ethiop-t1 fc collection-langafrican
"
TEXLIVE_MODULE_DOC_CONTENTS="ethiop.doc ethiop-t1.doc fc.doc "
TEXLIVE_MODULE_SRC_CONTENTS="ethiop.source "
inherit texlive-module
DESCRIPTION="TeXLive African scripts"

LICENSE="GPL-2 GPL-1 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

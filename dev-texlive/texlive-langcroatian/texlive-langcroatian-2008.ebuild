# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langcroatian/texlive-langcroatian-2008.ebuild,v 1.1 2008/09/09 16:32:57 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="croatian hrlatex hyphen-croatian collection-langcroatian
"
TEXLIVE_MODULE_DOC_CONTENTS="croatian.doc hrlatex.doc "
TEXLIVE_MODULE_SRC_CONTENTS="hrlatex.source "
inherit texlive-module
DESCRIPTION="TeXLive Croatian"

LICENSE="GPL-2 freedist LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

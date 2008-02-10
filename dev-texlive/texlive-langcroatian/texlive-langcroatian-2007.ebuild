# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langcroatian/texlive-langcroatian-2007.ebuild,v 1.8 2008/02/10 15:23:30 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="croatian hrlatex hyphen-croatian collection-langcroatian
"
inherit texlive-module
DESCRIPTION="TeXLive Croatian"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86 ~x86-fbsd"

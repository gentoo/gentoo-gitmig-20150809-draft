# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langgerman/texlive-langgerman-2007.ebuild,v 1.12 2008/04/08 05:49:15 jer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="german germbib hyphen-german mkind-german r-und-s uhrzeit umlaute collection-langgerman
"
inherit texlive-module
DESCRIPTION="TeXLive German"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd"

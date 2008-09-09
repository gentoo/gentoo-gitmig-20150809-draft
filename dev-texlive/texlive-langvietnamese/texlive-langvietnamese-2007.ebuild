# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langvietnamese/texlive-langvietnamese-2007.ebuild,v 1.16 2008/09/09 18:31:55 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="plnfss vntex collection-langvietnamese
"
inherit texlive-module
DESCRIPTION="TeXLive Vietnamese"

LICENSE="GPL-2 LPPL-1.3c font-adobe-utopia-type1 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

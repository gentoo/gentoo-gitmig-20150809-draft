# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langcyrillic/texlive-langcyrillic-2007.ebuild,v 1.16 2008/09/09 18:19:29 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="bghyphen bin-cyrillic cmcyr cmcyralt cyrillic cyrplain eskd eskdx gost hyphen-bulgarian hyphen-russian hyphen-ukrainian lh lhcyr ot2cyr ruhyphen t2 timescyr ukrhyph collection-langcyrillic"
# literat : Restrictive license
inherit texlive-module
DESCRIPTION="TeXLive Cyrillic"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

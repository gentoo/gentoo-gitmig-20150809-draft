# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langcjk/texlive-langcjk-2007-r1.ebuild,v 1.10 2008/05/12 19:31:47 nixnut Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic"

TEXLIVE_MODULE_CONTENTS="arphic c90enc cns garuda hyphen-pinyin norasi uhc wadalab yi4latex collection-langcjk
"
inherit texlive-module
DESCRIPTION="TeXLive Chinese, Japanese, Korean"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"

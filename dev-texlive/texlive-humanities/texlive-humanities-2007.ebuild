# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-humanities/texlive-humanities-2007.ebuild,v 1.15 2008/05/12 20:31:59 nixnut Exp $

TEXLIVE_MODULES_DEPS="!dev-tex/lineno"
TEXLIVE_MODULE_CONTENTS="alnumsec arydshln bibleref bigfoot camel covington dramatist ecltree ednotes jura juraabbrev juramisc jurarsp ledmac lexikon lineno linguex numline parallel parrun plari play poemscol qobitree qtree rtklage screenplay sides stage tree-dvips verse xyling collection-humanities
"
inherit texlive-module
DESCRIPTION="TeXLive LaTeX support for the humanities"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/latex-base/latex-base-1.0.ebuild,v 1.3 2007/10/15 01:16:10 mr_bones_ Exp $

DESCRIPTION="Virtual for basic latex binaries"
HOMEPAGE="http://www.ctan.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| (
	dev-texlive/texlive-latexrecommended
	app-text/tetex
	app-text/ptex
	app-text/cstetex
)"

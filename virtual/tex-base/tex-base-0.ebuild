# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/tex-base/tex-base-0.ebuild,v 1.2 2008/02/12 20:03:17 opfer Exp $

DESCRIPTION="Virtual for basic TeX binaries (tex, kpathsea)"
HOMEPAGE="http://www.ctan.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| (
		app-text/texlive-core
		app-text/tetex
		app-text/ptex
	)"

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ada/ada-1995.ebuild,v 1.2 2009/04/29 16:48:32 fauli Exp $

DESCRIPTION="Virtual for selecting an appropriate Ada compiler"
HOMEPAGE="http://www.gentoo.org/proj/en/glep/glep-0037.html"
SRC_URI=""
LICENSE="GPL-2"

# Different versions of Ada compilers can and likely will be installed side by
# side
SLOT="1995"

KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="|| (
	=dev-lang/gnat-gcc-4.2*
	=dev-lang/gnat-gcc-4.1*
	=dev-lang/gnat-gcc-3.4*
	=dev-lang/gnat-gpl-3.4* )"
DEPEND=""

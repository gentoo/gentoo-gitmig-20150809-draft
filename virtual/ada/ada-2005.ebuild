# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ada/ada-2005.ebuild,v 1.2 2008/04/15 12:07:18 george Exp $

DESCRIPTION="Virtual for selecting an appropriate Ada compiler."
HOMEPAGE="http://www.gentoo.org/proj/en/glep/glep-0037.html"
SRC_URI=""
LICENSE="GPL-2"
SLOT="2005"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

# Only one at present, but gnat-gcc-4.3 is coming soon too
RDEPEND="|| (
	>=dev-lang/gnat-gcc-4.3
	>=dev-lang/gnat-gpl-4.1 )"
DEPEND=""

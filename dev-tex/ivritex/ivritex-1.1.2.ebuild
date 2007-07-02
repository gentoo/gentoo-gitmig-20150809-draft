# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/ivritex/ivritex-1.1.2.ebuild,v 1.5 2007/07/02 15:07:36 peper Exp $

inherit latex-package

IUSE=""

DESCRIPTION="Hebrew support for TeX"
HOMEPAGE="http://ivritex.sourceforge.net/"
SRC_URI="mirror://sourceforge/ivritex/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="LPPL-1.2"

SLOT="0"
DEPEND="virtual/tetex"
KEYWORDS="x86 amd64"

src_install () {

	make TEX_ROOT=${D}/usr/share/texmf install || die

}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/ivritex/ivritex-1.1.1.ebuild,v 1.8 2004/06/25 02:14:22 agriffis Exp $

IUSE=""

DESCRIPTION="Hebrew support for TeX"
HOMEPAGE="http://ivritex.sourceforge.net/"
SRC_URI="mirror://sourceforge/ivritex/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="LPPL-1.2"

SLOT="0"
DEPEND="virtual/tetex"
KEYWORDS="x86 ~amd64"

src_install () {

	make TEX_ROOT=${D}/usr/share/texmf install || die

}

pkg_postinst() {

	einfo "Running texhash to complete installation.."
	addwrite "/var/lib/texmf"
	addwrite "/usr/share/texmf"
	addwrite "/var/cache/fonts"
	texhash
}

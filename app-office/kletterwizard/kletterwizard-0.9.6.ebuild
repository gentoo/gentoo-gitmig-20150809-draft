# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kletterwizard/kletterwizard-0.9.6.ebuild,v 1.2 2004/07/25 22:26:16 carlo Exp $

inherit kde

DESCRIPTION="KLetterWizard is a KDE application which simplifies letter writing and produces output via LaTeX."
HOMEPAGE="http://www.kluenter.de/klw.html"
SRC_URI="http://www.kluenter.de/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/tetex
		>=dev-tex/g-brief-4.0.1
		>=kde-base/kdegraphics-3.2.0"
need-kde 3

src_unpack() {
	kde_src_unpack
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	myconf="--with-texmf-path=${D}/usr/share/texmf"
	kde_src_compile
}

pkg_postinst() {
	einfo "Running texhash to complete install..."
	addwrite "/var/lib/texmf"
	addwrite "/usr/share/texmf"
	addwrite "/var/cache/fonts"
	texhash
}

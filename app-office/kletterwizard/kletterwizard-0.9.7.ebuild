# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kletterwizard/kletterwizard-0.9.7.ebuild,v 1.1 2006/02/15 15:22:11 carlo Exp $

inherit kde

DESCRIPTION="KLetterWizard is a KDE application which simplifies letter writing and produces output via LaTeX."
HOMEPAGE="http://www.kluenter.de/klw.html"
SRC_URI="http://www.kluenter.de/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/tetex
	|| ( kde-base/kghostview kde-base/kdegraphics )"

need-kde 3.4

src_unpack() {
	kde_src_unpack
	patch -p0 < ${FILESDIR}/${PN}-0.9.6-gentoo.diff
}

src_compile() {
	myconf="--with-texmf-path=/usr/share/texmf"
	kde_src_compile
}

pkg_postinst() {
	einfo "Running texhash to complete install..."
	addwrite "/var/lib/texmf"
	addwrite "/usr/share/texmf"
	addwrite "/var/cache/fonts"
	texhash
}

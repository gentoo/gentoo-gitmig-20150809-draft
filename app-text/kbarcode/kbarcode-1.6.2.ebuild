# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbarcode/kbarcode-1.6.2.ebuild,v 1.3 2004/07/03 20:34:40 carlo Exp $

inherit kde

DESCRIPTION="A KDE 3.x solution for barcode handling."
HOMEPAGE="http://www.kbarcode.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/kfile_kbarcode-0.1.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND=">=app-text/barcode-0.98"
RDEPEND=">=app-text/barcode-0.98
	media-gfx/imagemagick"
need-kde 3

src_compile()
{
	S=${WORKDIR}/${P}
	kde_src_compile all
	S=${WORKDIR}/kfile_kbarcode-0.1
	kde_src_compile all
}

src_install()
{
	S=${WORKDIR}/${P}
	kde_src_install
	S=${WORKDIR}/kfile_kbarcode-0.1
	kde_src_install
}

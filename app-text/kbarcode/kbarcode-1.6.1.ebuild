# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbarcode/kbarcode-1.6.1.ebuild,v 1.1 2004/01/06 18:53:16 caleb Exp $

inherit kde

IUSE="mysql"

DESCRIPTION="A KDE 3.x solution for barcode handling."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/kfile_kbarcode-0.1.tar.gz"
HOMEPAGE="http://www.kbarcode.net/"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=kde-base/kdelibs-3
	>=app-text/barcode-0.98"
RDEPEND="$DEPEND
	media-gfx/imagemagick"

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

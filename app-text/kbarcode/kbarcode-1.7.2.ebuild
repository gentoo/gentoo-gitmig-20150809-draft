# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbarcode/kbarcode-1.7.2.ebuild,v 1.1 2004/01/22 02:35:59 caleb Exp $

inherit kde
need-kde 3

IUSE=""
DESCRIPTION="A KDE 3.x solution for barcode handling."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.kbarcode.net/"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=kde-base/kdelibs-3
	>=app-text/barcode-0.98"
RDEPEND="$DEPEND
	media-gfx/imagemagick"


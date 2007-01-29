# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbarcode/kbarcode-1.8.1.ebuild,v 1.6 2007/01/29 01:57:54 mr_bones_ Exp $

inherit kde

DESCRIPTION="A KDE 3.x solution for barcode handling."
HOMEPAGE="http://www.kbarcode.net/"
SRC_URI="mirror://sourceforge/kbarcode/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=app-text/barcode-0.98"
RDEPEND=">=app-text/barcode-0.98
	virtual/ghostscript"
need-kde 3.3

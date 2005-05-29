# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbarcode/kbarcode-1.9.6.ebuild,v 1.1 2005/05/29 16:26:57 carlo Exp $

inherit kde

DESCRIPTION="A KDE 3.x solution for barcode handling."
HOMEPAGE="http://www.kbarcode.net/"
SRC_URI="mirror://sourceforge/kbarcode/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=app-text/barcode-0.98"
RDEPEND=">=app-text/barcode-0.98
	virtual/ghostscript"
need-kde 3.2
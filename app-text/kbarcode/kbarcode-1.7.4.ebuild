# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbarcode/kbarcode-1.7.4.ebuild,v 1.1 2004/06/12 14:27:23 carlo Exp $

inherit kde

DESCRIPTION="A KDE 3.x solution for barcode handling."
HOMEPAGE="http://www.kbarcode.net/"
SRC_URI="mirror://sourceforge/kbarcode/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=app-text/barcode-0.98"
RDEPEND=">=app-text/barcode-0.98
	virtual/ghostscript"

need-kde 3
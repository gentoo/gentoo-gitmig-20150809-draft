# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbarcode/kbarcode-1.2.0.ebuild,v 1.1 2003/04/30 17:39:20 caleb Exp $

inherit kde-base
need-kde 3

IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86"
DESCRIPTION="A KDE 3.x solution for barcode handling."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.kbarcode.net/"
DEPEND="app-text/barcode
	mysql ? ( dev-db/mysql )"

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbarcode/kbarcode-1.5.5.ebuild,v 1.1 2003/11/13 15:01:02 caleb Exp $

inherit kde
need-kde 3

IUSE="mysql"
LICENSE="GPL-2"
KEYWORDS="~x86"
DESCRIPTION="A KDE 3.x solution for barcode handling."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/kfile_kbarcode-0.1.tar.gz"
HOMEPAGE="http://www.kbarcode.net/"

newdepend ">=app-text/barcode-0.98
	mysql ? ( dev-db/mysql )"


# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbarcode/kbarcode-1.6.0_rc2.ebuild,v 1.1 2003/12/17 13:05:53 caleb Exp $

inherit kde
need-kde 3

IUSE="mysql"

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A KDE 3.x solution for barcode handling."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	mirror://sourceforge/${PN}/kfile_kbarcode-0.1.tar.gz"
HOMEPAGE="http://www.kbarcode.net/"
LICENSE="GPL-2"
KEYWORDS="x86"

newdepend ">=app-text/barcode-0.98
	mysql? ( dev-db/mysql )"


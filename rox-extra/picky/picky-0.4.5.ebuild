# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/picky/picky-0.4.5.ebuild,v 1.2 2005/03/05 23:37:36 josejx Exp $

DESCRIPTION="Picky - an image viewer/slideshow app for the ROX Desktop"

MY_PN="Picky"

HOMEPAGE="http://www.rdsarts.com/code/picky/"

SRC_URI="http://www.rdsarts.com/code/picky/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND=">=dev-python/pygtk-2.0.0"

ROX_LIB_VER=1.9.11

APPNAME=${MY_PN}

src_unpack() {
	unpack ${A}
	mkdir ${P}
	mkdir ${P}/${APPNAME}
	mv * ${P}/${APPNAME}
}

inherit rox

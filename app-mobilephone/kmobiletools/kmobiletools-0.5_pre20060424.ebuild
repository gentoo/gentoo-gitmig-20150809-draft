# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/kmobiletools/kmobiletools-0.5_pre20060424.ebuild,v 1.2 2006/04/24 15:52:19 flameeyes Exp $

inherit kde

SVNDATE="${PV#*pre}"
SVNNAME="svn-${SVNDATE:0:4}-${SVNDATE:4:2}-${SVNDATE:6:2}"

DESCRIPTION="KMobiletools is a KDE-based application that allows to control mobile phones with your PC."
SRC_URI="http://xoomer.virgilio.it/rockman81/kmobiletools/${PN}-${SVNNAME}.tar.bz2"
HOMEPAGE="http://www.kmobiletools.org/"
LICENSE="GPL-2"

IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="kde? ( kde-base/libkcal
	kde-base/kontact )"

S="${WORKDIR}/svn-${PN}"

need-kde 3.3

src_compile() {
	myconf="${myconf} $(use_enable kde libkcal)
		$(use_enable kde kontact-plugin)"

	kde_src_compile
}


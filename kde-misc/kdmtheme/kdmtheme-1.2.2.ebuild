# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdmtheme/kdmtheme-1.2.2.ebuild,v 1.5 2009/06/28 11:59:23 tampakrap Exp $

inherit kde

DESCRIPTION="KDM Theme Manager is a Control Center module for changing KDM theme"
HOMEPAGE="http://beta.smileaf.org/"
SRC_URI="http://beta.smileaf.org/files/kdmtheme/${P}.tar.bz2
		mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

IUSE=""
SLOT="3.5"

need-kde 3.5

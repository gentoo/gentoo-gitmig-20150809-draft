# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/knoda/knoda-0.6.3_alpha3.ebuild,v 1.3 2004/03/24 23:52:45 mholzer Exp $

inherit kde-base
need-kde 3

MY_P=${P/_alpha3/-test3}

S=${WORKDIR}/${MY_P}

IUSE=""
DESCRIPTION="KDE database frontend based on the hk_classes library"
SRC_URI="mirror://sourceforge/knoda/${MY_P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://hk-classes.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
DEPEND=">=kde-base/kdelibs-3
	>=dev-db/hk_classes-${PV}"


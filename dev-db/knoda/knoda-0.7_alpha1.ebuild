# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/knoda/knoda-0.7_alpha1.ebuild,v 1.1 2004/05/17 23:03:26 caleb Exp $

inherit kde-base
DEPEND=">=kde-base/kdelibs-3
	>=dev-db/hk_classes-${PV}"
need-kde 3

MY_P=${P/_alpha1/-test1}
S=${WORKDIR}/${MY_P}

IUSE=""
DESCRIPTION="KDE database frontend based on the hk_classes library"
SRC_URI="mirror://sourceforge/knoda/${MY_P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://hk-classes.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"


# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/knoda/knoda-0.6.3_alpha1.ebuild,v 1.1 2003/12/27 16:23:47 caleb Exp $

inherit kde-base
need-kde 3

MY_P=${P/_alpha1/-test1}

S=${WORKDIR}/${MY_P}

IUSE=""
DESCRIPTION="KDE database frontend based on the hk_classes library"
SRC_URI="mirror://sourceforge/sourceforge/knoda/${MY_P}.tar.bz2"
HOMEPAGE="http://hk-classes.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~x86"
newdepend ">=dev-db/hk_classes-${PV}"


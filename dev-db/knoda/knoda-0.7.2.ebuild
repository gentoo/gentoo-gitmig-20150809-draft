# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/knoda/knoda-0.7.2.ebuild,v 1.1 2004/12/07 00:49:05 caleb Exp $

inherit kde

MY_P=${P/_alpha/-test}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KDE database frontend based on the hk_classes library"
HOMEPAGE="http://hk-classes.sourceforge.net/"
SRC_URI="mirror://sourceforge/knoda/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-db/hk_classes-${PV}"
need-kde 3

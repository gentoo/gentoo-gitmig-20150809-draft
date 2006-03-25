# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/knoda/knoda-0.8.1_alpha3.ebuild,v 1.1 2006/03/25 12:34:51 caleb Exp $

inherit kde

MY_P=${P/_alpha/-test}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KDE database frontend based on the hk_classes library"
HOMEPAGE="http://hk-classes.sourceforge.net/"
SRC_URI="mirror://sourceforge/knoda/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="~dev-db/hk_classes-${PV}"

need-kde 3


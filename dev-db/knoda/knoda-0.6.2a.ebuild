# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/knoda/knoda-0.6.2a.ebuild,v 1.6 2004/06/24 21:55:02 agriffis Exp $

inherit kde
need-kde 3

#S=${WORKDIR}/${P}

IUSE=""
DESCRIPTION="KDE database frontend based on the hk_classes library"
SRC_URI="mirror://sourceforge/knoda/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://hk-classes.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="x86"

newdepend ">=dev-db/hk_classes-0.6.2a"

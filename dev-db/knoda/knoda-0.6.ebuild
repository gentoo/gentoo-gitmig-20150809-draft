# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/knoda/knoda-0.6.ebuild,v 1.1 2003/05/28 14:19:03 caleb Exp $

inherit kde-base 
need-kde 3 

S=${WORKDIR}/${P}

IUSE=""
DESCRIPTION="KDE database frontend based on the hk_classes library"
SRC_URI="mirror://sourceforge/sourceforge/knoda/${P}.tar.gz"
HOMEPAGE="http://hk-classes.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="x86"

newdepend ">=dev-db/hk_classes-0.6"

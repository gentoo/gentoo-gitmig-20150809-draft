# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/quanta/quanta-3.2.2.ebuild,v 1.8 2005/01/01 13:33:48 eradicator Exp $

inherit kde
DEPEND="doc? ( app-doc/quanta-docs )"
need-kde 3.2

DESCRIPTION="A superb web development tool for KDE 3.x"
HOMEPAGE="http://quanta.sourceforge.net/"
SRC_URI="mirror://kde/stable/${PV}/src/${P}.tar.bz2"
IUSE="doc"


LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64 sparc"

SLOT="0"


# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/quanta/quanta-3.2.3.ebuild,v 1.5 2004/10/05 12:19:43 pvdabeel Exp $

inherit kde

DESCRIPTION="A superb web development tool for KDE 3.x"
HOMEPAGE="http://quanta.sourceforge.net/"
SRC_URI="mirror://kde/stable/${PV}/src/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64 sparc"
IUSE="doc"

DEPEND="doc? ( app-doc/quanta-docs )"

need-kde 3.2



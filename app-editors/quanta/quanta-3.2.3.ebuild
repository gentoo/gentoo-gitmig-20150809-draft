# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/quanta/quanta-3.2.3.ebuild,v 1.7 2005/01/14 23:22:59 danarmak Exp $

inherit kde

DESCRIPTION="A superb web development tool for KDE 3.x"
HOMEPAGE="http://quanta.sourceforge.net/"
SRC_URI="mirror://kde/stable/${PV}/src/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64 sparc"
IUSE="doc"

DEPEND="doc? ( app-doc/quanta-docs ) !kde-base/quanta !>=kde-base/kdewebdev-3.4.0_alpha1"

need-kde 3.2



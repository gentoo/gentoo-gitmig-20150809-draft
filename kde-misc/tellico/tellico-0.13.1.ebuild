# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tellico/tellico-0.13.1.ebuild,v 1.4 2005/01/25 13:39:02 weeve Exp $

inherit kde

DESCRIPTION="A collection manager for the KDE environment"
HOMEPAGE="http://www.periapsis.org/tellico"
SRC_URI="http://www.periapsis.org/tellico/download/${P}.tar.gz"

KEYWORDS="x86 sparc ~ppc ~amd64"
LICENSE="GPL-2"

IUSE=""
SLOT="0"

DEPEND=">=dev-libs/libxml2-2.4.23
	>=dev-libs/libxslt-1.0.19
	|| ( kde-base/kdemultimedia-meta kde-base/kdemultimedia )"

need-kde 3.2

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tellico/tellico-0.12.ebuild,v 1.1 2004/10/30 18:26:51 carlo Exp $

inherit kde

DESCRIPTION="A collection manager for the KDE environment"
HOMEPAGE="http://www.periapsis.org/tellico"
SRC_URI="http://www.periapsis.org/tellico/download/${P}.tar.gz"

KEYWORDS="x86 ~sparc ~ppc"
LICENSE="GPL-2"

IUSE=""
SLOT="0"

DEPEND=">=dev-libs/libxml2-2.4.23
	>=dev-libs/libxslt-1.0.19
	kde-base/kdemultimedia
	media-sound/cdparanoia"

need-kde 3.2

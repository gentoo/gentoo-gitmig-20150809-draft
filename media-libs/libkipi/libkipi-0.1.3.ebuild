# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkipi/libkipi-0.1.3.ebuild,v 1.1 2006/05/20 16:32:58 carlo Exp $

inherit kde

DESCRIPTION="A library for image plugins accross KDE applications."
HOMEPAGE="http://extragear.kde.org/apps/kipi/"
SRC_URI="mirror://sourceforge/kipi/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-util/pkgconfig"
need-kde 3.4

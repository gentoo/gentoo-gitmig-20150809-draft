# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/compizconfig-backend-kconfig/compizconfig-backend-kconfig-0.8.2.ebuild,v 1.3 2009/04/25 16:04:41 ranger Exp $

ARTS_REQUIRED="never"
NEED_KDE="3.5"

inherit kde

DESCRIPTION="Compizconfig Kconfig Backend"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="~x11-libs/libcompizconfig-${PV}
	~x11-wm/compiz-${PV}"
RDEPEND="${DEPEND}"

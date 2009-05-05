# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/compizconfig-backend-kconfig/compizconfig-backend-kconfig-0.6.0.ebuild,v 1.6 2009/05/05 08:17:51 ssuominen Exp $

inherit kde

DESCRIPTION="libcompizconfig kde config backend"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="http://releases.compiz-fusion.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-wm/compiz-0.6.0
	>=x11-libs/libcompizconfig-0.6.0"
DEPEND="${RDEPEND}"

need-kde 3.5

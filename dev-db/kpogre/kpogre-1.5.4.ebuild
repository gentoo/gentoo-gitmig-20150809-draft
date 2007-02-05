# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/kpogre/kpogre-1.5.4.ebuild,v 1.1 2007/02/05 16:06:36 dev-zero Exp $

inherit kde

KEYWORDS="~alpha ~amd64 ~ppc ~x86"

DESCRIPTION="KDE GUI for PostgreSQL."
HOMEPAGE="http://kpogre.sourceforge.net/"
SRC_URI="mirror://sourceforge/kpogre/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/libpqxx-2.6.8"
RDEPEND="${DEPEND}"

need-kde 3.5

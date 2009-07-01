# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/kpogre/kpogre-1.6.6.ebuild,v 1.4 2009/07/01 12:31:20 fauli Exp $

inherit kde

KEYWORDS="~alpha ~amd64 ~ppc x86"

DESCRIPTION="KDE GUI for PostgreSQL."
HOMEPAGE="http://kpogre.sourceforge.net/"
SRC_URI="mirror://sourceforge/kpogre/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/libpqxx-2.6.9"
RDEPEND="${DEPEND}"

need-kde 3.5

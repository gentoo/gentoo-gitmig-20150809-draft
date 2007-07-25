# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-news/eselect-news-20070709.ebuild,v 1.5 2007/07/25 16:12:26 peper Exp $

DESCRIPTION="GLEP 42 news reader"
HOMEPAGE="http://paludis.pioto.org/"
SRC_URI="http://paludis.pioto.org/download/news.eselect-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

# Forces eselect-news to be pulled after paludis and hence ease the upgrade
# path for users with collision-protect.
DEPEND=">=sys-apps/paludis-0.24.5"

RDEPEND="app-admin/eselect"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${DISTDIR}/news.eselect-${PV}" news.eselect || die
}

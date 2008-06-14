# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kbeam/kbeam-0.61-r1.ebuild,v 1.4 2008/06/14 13:21:19 tgurr Exp $

inherit kde autotools

DESCRIPTION="A KDE application that lets you send and receive files to devices, using your Infrared port."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=14683"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"

DEPEND=">=dev-libs/openobex-1.1"

RDEPEND="${DEPEND}"

need-kde 3.5

src_unpack() {
	kde_src_unpack

	epatch "${FILESDIR}/${P}-aclocal_openobex.patch"
	epatch "${FILESDIR}/${P}-gcc43.patch"

	#need it for using the AM_PATH_OPENOBEX definition installed in system
	eaclocal && eautoconf || die "eaclocal or eautoconf has failed"
}

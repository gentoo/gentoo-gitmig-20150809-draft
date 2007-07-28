# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ptabtools/ptabtools-0.4.3.ebuild,v 1.1 2007/07/28 14:25:19 drac Exp $

DESCRIPTION="Utilities for PowerTab Guitar files (.ptb)"
HOMEPAGE="http://jelmer.vernstok.nl/oss/ptabtools"
SRC_URI="http://jelmer.vernstok.nl/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-libs/popt
	dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README ROADMAP TODO
}

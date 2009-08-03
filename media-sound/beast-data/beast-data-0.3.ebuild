# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beast-data/beast-data-0.3.ebuild,v 1.13 2009/08/03 12:51:32 ssuominen Exp $

DESCRIPTION="BEAST - the Bedevilled Sound Engine (datafiles)"
HOMEPAGE="http://beast.gtk.org"
SRC_URI="ftp://beast.gtk.org/pub/beast/v0.3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-sound/beast-0.4.1"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/cwdaemon/cwdaemon-0.9.4.ebuild,v 1.2 2010/12/20 12:30:46 klausman Exp $

DESCRIPTION="A morse daemon for the parallel or serial port"
HOMEPAGE="http://www.ibiblio.org/pub/linux/apps/ham/morse"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

RDEPEND=">=media-radio/unixcw-2.3"
DEPEND="$RDEPEND
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/cwdaemon/cwdaemon-0.9.4.ebuild,v 1.1 2010/09/25 11:52:32 tomjbe Exp $

DESCRIPTION="A morse daemon for the parallel or serial port"
HOMEPAGE="http://www.ibiblio.org/pub/linux/apps/ham/morse"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-radio/unixcw-2.3"
DEPEND="$RDEPEND
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}

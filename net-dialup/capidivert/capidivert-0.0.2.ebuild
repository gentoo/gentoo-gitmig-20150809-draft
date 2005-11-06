# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capidivert/capidivert-0.0.2.ebuild,v 1.1 2005/11/06 01:49:05 sbriesen Exp $

DESCRIPTION="CAPI based utility to control ISDN diversion facilities"
HOMEPAGE="http://www.tp1.ruhr-uni-bochum.de/~kai/i4l/capidivert/"
SRC_URI="http://www.tp1.ruhr-uni-bochum.de/~kai/i4l/capidivert/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="net-dialup/capi4k-utils"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}

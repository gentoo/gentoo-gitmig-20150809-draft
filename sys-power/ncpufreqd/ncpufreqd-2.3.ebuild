# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/ncpufreqd/ncpufreqd-2.3.ebuild,v 1.4 2007/10/05 14:55:56 opfer Exp $

DESCRIPTION="Daemon controlling CPU speed and temperature"
HOMEPAGE="http://projects.simpledesigns.com.pl/project/ncpufreqd/"
SRC_URI="http://projects.simpledesigns.com.pl/get/${P}.tar.bz2"
LICENSE="ZLIB"

SLOT="0"
KEYWORDS="~amd64 x86"

IUSE=""

DEPEND="virtual/logger"

src_install() {
	make DESTDIR="${D}" install || die "emake install failed"

	doinitd "${S}"/gentoo-init.d/ncpufreqd
	dodoc AUTHORS ChangeLog NEWS README
}

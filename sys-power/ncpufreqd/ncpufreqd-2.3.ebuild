# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/ncpufreqd/ncpufreqd-2.3.ebuild,v 1.1 2007/02/22 23:25:11 nelchael Exp $

DESCRIPTION="Daemon controlling CPU speed and temperature"
HOMEPAGE="http://www.nelchael.net/"
SRC_URI="http://download.nelchael.net/${PN}/${P}.tar.bz2"
LICENSE="ZLIB"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="virtual/logger"

src_install() {
	make DESTDIR=${D} install || die "emake install failed"

	exeinto /etc/init.d
	doexe ${S}/gentoo-init.d/ncpufreqd
	dodoc AUTHORS ChangeLog NEWS README
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/ncpufreqd/ncpufreqd-2.0.ebuild,v 1.4 2006/07/12 21:15:26 nelchael Exp $

DESCRIPTION="Daemon controlling CPU speed and temperature"
HOMEPAGE="http://www.nelchael.net/"
SRC_URI="http://www.nelchael.net/files/${PN}/${P}.tar.bz2"
LICENSE="ZLIB"

SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

DEPEND="virtual/logger"

src_install() {
	make DESTDIR=${D} install || die "emake install failed"

	exeinto /etc/init.d
	doexe ${S}/gentoo-init.d/ncpufreqd
	dodoc AUTHORS ChangeLog NEWS README
}

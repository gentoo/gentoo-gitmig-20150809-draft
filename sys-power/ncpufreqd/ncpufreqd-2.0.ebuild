# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/ncpufreqd/ncpufreqd-2.0.ebuild,v 1.3 2005/10/30 19:25:37 metalgod Exp $

DESCRIPTION="Daemon controlling CPU speed and temperature"
HOMEPAGE="http://fatcat.ftj.agh.edu.pl/~nelchael/"
SRC_URI="http://fatcat.ftj.agh.edu.pl/~nelchael/files/ncpufreqd/${P}.tar.bz2"
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

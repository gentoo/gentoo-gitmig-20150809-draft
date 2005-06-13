# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/ncpufreqd/ncpufreqd-1.9.ebuild,v 1.1 2005/06/13 19:12:43 sekretarz Exp $

DESCRIPTION="Daemon controlling CPU speed and temperature"
HOMEPAGE="http://fatcat.ftj.agh.edu.pl/~nelchael/"
SRC_URI="http://fatcat.ftj.agh.edu.pl/~nelchael/files/ncpufreqd/${P}.tar.bz2"
LICENSE="ZLIB"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="virtual/logger"

src_compile() {
	./configure --prefix=${D} || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "emake install failed"

	exeinto /etc/init.d
	doexe ${S}/gentoo-init.d/ncpufreqd
	dodoc INSTALL LICENCE README
}

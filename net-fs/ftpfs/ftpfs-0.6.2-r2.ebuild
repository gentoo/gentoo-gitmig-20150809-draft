# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-fs/ftpfs/ftpfs-0.6.2-r2.ebuild,v 1.8 2002/08/01 11:40:16 seemant Exp $

MY_P=${P}-k2.4
S=${WORKDIR}/${MY_P}
DESCRIPTION="A filesystem for mounting FTP volumes"
SRC_URI="http://ftp1.sourceforge.net/ftpfs/${MY_P}.tar.gz"
HOMEPAGE="http://ftpfs.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/linux-sources
	>=sys-apps/portage-1.9.10"

src_compile() {
	check_KV
	cd ftpfs
	make || die
	cd ../ftpmount
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	mv ftpfs/Makefile ftpfs/Makefile.old
	sed s:"depmod -aq"::g \
	 ftpfs/Makefile.old > ftpfs/Makefile

	make \
		MODULESDIR=${D}/lib/modules/${KV} \
		FTPMOUNT=${D}/usr/bin/ftpmount \
		install || die

	dodoc CHANGELOG
	dohtml -r docs
}

pkg_postinst() {
	echo "running depmod...."
	depmod -aq || die
}

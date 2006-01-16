# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/i8kutils/i8kutils-1.25.ebuild,v 1.8 2006/01/16 04:45:43 halcy0n Exp $



DESCRIPTION="Dell Inspiron and Latitude utilities"
HOMEPAGE="http://people.debian.org/~dz/i8k/"
SRC_URI="http://people.debian.org/~dz/i8k/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86 amd64"
IUSE="tcltk"

DEPEND="virtual/libc
	tcltk? ( >=dev-lang/tk-8.3.3 )"

src_compile() {
	make all || die
}

src_install() {
	dobin i8kbuttons i8kctl
	doman i8kbuttons.1 i8kctl.1
	dosym /usr/bin/i8kctl /usr/bin/i8kfan
	dodoc README.i8kutils
	docinto examples/
	dodoc examples/*

	insinto /etc/init.d
	newins ${FILESDIR}/i8k.init i8k
	fperms 755 /etc/init.d/i8k
	insinto /etc/conf.d
	newins ${FILESDIR}/i8k.conf i8k

	if use tcltk
	then
		dobin i8kmon
		doman i8kmon.1
		docinto /
		dodoc i8kmon.conf
	else
		echo >> ${D}/etc/conf.d/i8k
		echo '# i8kmon disabled because the package was installed without USE=tcltk' >> ${D}/etc/conf.d/i8k
		echo 'NOMON=1' >> ${D}/etc/conf.d/i8k
	fi

}

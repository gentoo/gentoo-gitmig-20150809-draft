# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dnetc/dnetc-2.8010.463.ebuild,v 1.7 2003/02/13 08:55:39 vapier Exp $

MAJ_PV=${PV:0:6}
MIN_PV=${PV:7:9}

DESCRIPTION="distributed.net client"
HOMEPAGE="http://www.distributed.net"
SRC_URI="alpha? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-alpha-elf.tar.gz )
	x86? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-x86-elf.tar.gz )
	mips? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-mips.tar.gz )"
LICENSE="distributed.net"
SLOT="0"
KEYWORDS="x86 -ppc -sparc ~alpha ~mips"
IUSE=""
DEPEND=""
RDEPEND="net-misc/host"
S="${WORKDIR}"
RESTRICT="nomirror"

src_install() {
	exeinto /opt/distributed.net
	doexe dnetc

	doman dnetc.1
	dodoc docs/*

	exeinto /etc/init.d ; newexe ${FILESDIR}/dnetc.init dnetc
	insinto /etc/conf.d ; newins ${FILESDIR}/dnetc.conf dnetc
}

pkg_postinst() {
	einfo "Either configure your email adress in /etc/conf.d/dnetc"
	einfo "or create the configuration file /opt/distributed.net/dnetc.ini"
}

pkg_postrm() {
	if [ -d /opt/distributed.net ]; then
		einfo "All files has not been removed from /opt/distributed.net"
	fi
}

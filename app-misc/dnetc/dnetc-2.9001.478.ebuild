# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dnetc/dnetc-2.9001.478.ebuild,v 1.2 2002/12/03 13:49:18 aliz Exp $

MAJ_PV=${PV:0:6}
MIN_PV=${PV:7:9}

DESCRIPTION="distributed.net client"
HOMEPAGE="http://www.distributed.net"
SRC_URI="ppc? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-ppc.tar.gz )
	x86? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-x86-elf.tar.gz )"
LICENSE="distributed.net"
SLOT="0"
KEYWORDS="x86 ~ppc -sparc -sparc64 -alpha"
IUSE=""
DEPEND=""
#RDEPEND=""
if [ `use x86` ]; then
	S="${WORKDIR}/dnetc${MIN_PV}-linux-x86-elf"
elif [ `use ppc` ]; then
	S="${WORKDIR}/dnetc${MIN_PV}-linux-ppc"
fi

RESTRICT="nomirror"

src_install() {
	exeinto /opt/distributed.net
	doexe dnetc

	doman dnetc.1
	dodoc CHANGES.txt dnetc.txt readme.*

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

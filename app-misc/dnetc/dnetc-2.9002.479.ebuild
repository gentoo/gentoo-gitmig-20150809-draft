# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dnetc/dnetc-2.9002.479.ebuild,v 1.1 2003/11/26 10:40:18 aliz Exp $

MAJ_PV=${PV:0:6}
MIN_PV=${PV:7:9}

DESCRIPTION="distributed.net client"
HOMEPAGE="http://www.distributed.net"
SRC_URI="hppa? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-hppa32.tar.gz )"
LICENSE="distributed.net"
SLOT="0"
KEYWORDS="~hppa"
IUSE=""
DEPEND=""
RDEPEND="net-misc/host"
if [ `use hppa` ]; then
	S="${WORKDIR}/dnetc${MIN_PV}-linux-hppa"
fi

RESTRICT="nomirror"

pkg_preinst() {
	if [ -e /opt/distributed.net/dnetc ] && [ -e /etc/init.d/dnetc ]; then
		einfo "flushing old buffers"
		/opt/distributed.net/dnetc -quiet -flush
		einfo "removing old buffer files"
		rm -f /opt/distributed.net/buff*
	fi
}

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

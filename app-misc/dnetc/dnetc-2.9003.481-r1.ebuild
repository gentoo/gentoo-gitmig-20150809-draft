# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dnetc/dnetc-2.9003.481-r1.ebuild,v 1.12 2007/08/23 17:59:25 wolf31o2 Exp $

MAJ_PV=${PV:0:6}
MIN_PV=${PV:7:9}

DESCRIPTION="distributed.net client"
HOMEPAGE="http://www.distributed.net"
SRC_URI="ppc? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-ppc.tar.gz )
	arm? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-arm-elf.tar.gz )
	x86? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-x86-elf.tar.gz )
	sparc? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-sparc.tar.gz )
	alpha? ( ftp://ftp.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-alpha5-static.tar.gz )"

LICENSE="distributed.net"
SLOT="0"
KEYWORDS="alpha ppc sparc x86"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND="net-dns/bind-tools"

if use x86; then
	S="${WORKDIR}/dnetc${MIN_PV}-linux-x86-elf"
elif use ppc; then
	S="${WORKDIR}/dnetc${MIN_PV}-linux-ppc"
elif use sparc; then
	S="${WORKDIR}/dnetc${MIN_PV}-linux-sparc"
elif use arm; then
	S="${WORKDIR}/dnetc${MIN_PV}-linux-arm-elf"
elif use alpha; then
	S="${WORKDIR}/dnetc${MIN_PV}-linux-alpha5-static"
fi

src_install() {
	exeinto /opt/distributed.net
	doexe dnetc

	doman dnetc.1
	dodoc CHANGES.txt dnetc.txt readme.*

	newinitd ${FILESDIR}/dnetc.init dnetc
	newconfd ${FILESDIR}/dnetc.conf dnetc
}

pkg_preinst() {
	if [ -e /opt/distributed.net/dnetc ] && [ -e /etc/init.d/dnetc ]; then
		einfo "flushing old buffers"
		/opt/distributed.net/dnetc -quiet -flush
		einfo "removing old buffer files"
		rm -f /opt/distributed.net/buff*
	fi
}

pkg_postinst() {
	elog "Either configure your email address in /etc/conf.d/dnetc"
	elog "or create the configuration file /opt/distributed.net/dnetc.ini"
}

pkg_postrm() {
	if [ -d /opt/distributed.net ]; then
		elog "All files has not been removed from /opt/distributed.net"
	fi
}

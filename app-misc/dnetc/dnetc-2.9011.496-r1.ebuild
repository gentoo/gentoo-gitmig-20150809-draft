# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dnetc/dnetc-2.9011.496-r1.ebuild,v 1.7 2007/08/23 17:59:25 wolf31o2 Exp $

inherit eutils

MAJ_PV=${PV:0:6}
MIN_PV=${PV:7:9}

DESCRIPTION="distributed.net client"
HOMEPAGE="http://www.distributed.net"
SRC_URI="x86? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-x86-elf-uclibc.tar.gz )
	amd64? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-amd64-elf.tar.gz )"

LICENSE="distributed.net"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND="net-dns/bind-tools"

if use amd64; then
	S="${WORKDIR}/dnetc${MIN_PV}-linux-amd64-elf"
elif use x86; then
	S="${WORKDIR}/dnetc${MIN_PV}-linux-x86-elf-uclibc"
fi

src_install() {
	exeinto /opt/distributed.net
	doexe dnetc

	doman dnetc.1
	dodoc docs/CHANGES.txt docs/dnetc.txt docs/readme.*

	newinitd ${FILESDIR}/dnetc.init-r1 dnetc
	newconfd ${FILESDIR}/dnetc.conf dnetc
}

pkg_preinst() {
	if [ -e /opt/distributed.net/dnetc ] && [ -e /etc/init.d/dnetc ]; then
		einfo "flushing old buffers"
		source /etc/conf.d/dnetc

		if [ -e /opt/distributed.net/dnetc.ini ]; then
			# use ini file
			/opt/distributed.net/dnetc -quiet -ini /opt/distributed.net/dnetc.ini -flush
		elif [ ! -e /opt/distributed.net/dnetc.ini ] && [ ! -z ${EMAIL} ]; then
			# email adress from config
			/opt/distributed.net/dnetc -quiet -flush -e ${EMAIL}
		fi

		einfo "removing old buffer files"
		rm -f /opt/distributed.net/buff*
	fi

	enewgroup dnetc
	enewuser dnetc -1 -1 /opt/distributed.net dnetc
}

pkg_postinst() {
	chown -Rf dnetc:dnetc /opt/distributed.net
	chmod 0555 /opt/distributed.net/dnetc

	elog "To run distributed.net client in the background at boot:"
	elog "   rc-update add dnetc default"
	elog ""
	elog "Either configure your email address in /etc/conf.d/dnetc"
	elog "or create the configuration file /opt/distributed.net/dnetc.ini"
}

pkg_postrm() {
	if [ -d /opt/distributed.net ]; then
		elog "All files has not been removed from /opt/distributed.net"
	fi
}

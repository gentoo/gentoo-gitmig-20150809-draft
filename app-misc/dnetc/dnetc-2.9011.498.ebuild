# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dnetc/dnetc-2.9011.498.ebuild,v 1.7 2009/11/18 15:02:07 jer Exp $

inherit eutils versionator

MAJ_PV="$(get_major_version).$(get_version_component_range 2)"
MIN_PV="$(get_version_component_range 3)"

DESCRIPTION="distributed.net client"
HOMEPAGE="http://www.distributed.net"
SRC_URI="http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-x86-elf-uclibc.tar.gz"

LICENSE="distributed.net"
SLOT="0"
KEYWORDS="~x86 -*"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND=""

QA_PRESTRIPPED="opt/distributed.net/dnetc"

S="${WORKDIR}/dnetc${MIN_PV}-linux-x86-elf-uclibc"

pkg_setup() {
	enewgroup dnetc
	enewuser dnetc -1 -1 /opt/distributed.net dnetc
}

src_install() {
	newinitd "${FILESDIR}"/dnetc.initd dnetc
	newconfd "${FILESDIR}"/dnetc.confd dnetc

	local ownopts="--mode=0555 --group=dnetc --owner=dnetc"

	diropts ${ownopts}
	dodir /opt/distributed.net

	exeopts ${ownopts}
	exeinto /opt/distributed.net
	doexe dnetc

	doman dnetc.1
	dodoc docs/CHANGES.txt docs/dnetc.txt docs/readme.*
}

pkg_preinst() {
	if [ -e /opt/distributed.net/dnetc ] && [ -e /etc/init.d/dnetc ]; then
		ebegin "Flushing old buffers"
		source /etc/conf.d/dnetc

		if [ -e /opt/distributed.net/dnetc.ini ]; then
			# use ini file
			/opt/distributed.net/dnetc -quiet -ini /opt/distributed.net/dnetc.ini -flush
		elif [ ! -e /opt/distributed.net/dnetc.ini ] && [ ! -z ${EMAIL} ]; then
			# email adress from config
			/opt/distributed.net/dnetc -quiet -flush -e ${EMAIL}
		fi

		eend ${?}
	fi
}

pkg_postinst() {
	elog "To run distributed.net client in the background at boot:"
	elog "   rc-update add dnetc default"
	elog
	elog "Either configure your email address in /etc/conf.d/dnetc"
	elog "or create the configuration file /opt/distributed.net/dnetc.ini"
}

pkg_postrm() {
	if [ -d /opt/distributed.net ]; then
		elog "All files has not been removed from /opt/distributed.net"
		elog "Probably old init file and/or buffer files"
	fi
}

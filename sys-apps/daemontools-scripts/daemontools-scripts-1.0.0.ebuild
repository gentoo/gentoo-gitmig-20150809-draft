# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/daemontools-scripts/daemontools-scripts-1.0.0.ebuild,v 1.2 2004/12/07 09:33:26 kaiowas Exp $

inherit eutils flag-o-matic

DESCRIPTION="gentoo specific daemontools wrapper scripts"
HOMEPAGE="http://dev.gentoo.org/~kaiowas/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="static selinux withsamplescripts"

RDEPEND="selinux? ( sys-apps/policycoreutils )
		sys-apps/daemontools"
DEPEND=""

src_compile() {
	use static && append-ldflags -static

	make -C ${S}/src CC="${CC:-gcc}" LD="${CC:-gcc} ${LDFLAGS}" \
		CFLAGS="${CFLAGS}" || die
}

pkg_setup() {

	use withsamplescripts && ( echo ${CONFIG_PROTECT} | grep '/var/service' >/dev/null || \
		if [ -d /var/service ]; then
			ewarn ""
			ewarn "PLEASE NOTE: You are currently using /var/service for"
			ewarn "some daemontools services."
			ewarn "In order to avoid damages to your system, please run"
			ewarn ""
			ewarn "echo 'CONFIG_PROTECT=\"/var/service\"' > /etc/env.d/51svcinit"
			ewarn "env-update"
			ewarn "source /etc/profile"
			ewarn ""
			epause 15
		fi
	)

}

src_install() {

	into /
	doenvd ${S}/etc/env.d/50svcinit
	dosbin ${S}/sbin/*
	dosbin ${S}/src/svcinit

	# usage() script
	exeinto /lib/rcscripts/sh
	doexe ${S}/lib/rcscripts/sh/*

	# this directory is targeted by daemontools
	keepdir /service

	use withsamplescripts && (

		# fill up /var/service/*
		keepdir /var/service

		cd ${S}/var/service

		services=`find ./ -type d`
		for service in ${services}; do
			dodir /var/service/${item}
		done

		files=`find ./ -type f`
		for file in ${files}; do
			path=`dirname ${file}`
			exeinto /var/service/${path}
			doexe ${file}
		done
	)
}



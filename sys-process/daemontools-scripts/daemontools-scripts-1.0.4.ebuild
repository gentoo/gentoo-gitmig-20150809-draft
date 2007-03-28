# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/daemontools-scripts/daemontools-scripts-1.0.4.ebuild,v 1.3 2007/03/28 08:16:40 kaiowas Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="gentoo specific daemontools wrapper scripts"
HOMEPAGE="http://dev.gentoo.org/~kaiowas/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="static selinux withsamplescripts"

RDEPEND="selinux? ( sys-apps/policycoreutils )"
DEPEND=""

src_compile() {
	use static && append-ldflags -static

	make -C ${S}/src CC="$(tc-getCC)" LD="$(tc-getCC) ${LDFLAGS}" \
		CFLAGS="${CFLAGS}" || die
}

pkg_setup() {

	use withsamplescripts && ( echo "${CONFIG_PROTECT}" | grep '/var/service' >/dev/null || \
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
	doenvd etc/env.d/50svcinit
	dosbin sbin/* || die
	dosbin src/svcinit || die

	# usage() script
	exeinto /$(get_libdir)/rcscripts/sh
	doexe lib/rcscripts/sh/* || die

	if use withsamplescripts ; then

		# fill up /var/service/*
		keepdir /var/service

		cd "${S}"/var/service

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
	fi
}



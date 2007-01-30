# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/resolvconf-gentoo/resolvconf-gentoo-1.2.ebuild,v 1.11 2007/01/30 05:49:17 beandog Exp $

inherit eutils

DESCRIPTION="A framework for managing DNS information"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~uberlord/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash"

src_install() {
	make ROOT="${D}" install || die "Failed to install"
}

pkg_postinst() {
	if [[ ! -"L ${ROOT}/etc/resolv.conf" ]] \
		|| [[ $(readlink "${ROOT}/etc/resolv.conf") != \
		"resolvconf/run/resolv.conf" ]] ; then
		ewarn "resolvconf requires ${ROOT}/etc/resolv.conf to be a symbolic"
		ewarn "to resolvconf/run/resolv.conf"
		einfo "To set this up automatically type"
		einfo "   emerge --config =${PF}"
	fi
}

pkg_config() {
	cd "${ROOT}/etc"
	if [[ -L resolv.conf && $(readlink resolv.conf) == \
		"resolvconf/run/resolv.conf" ]] ; then
		einfo "${ROOT}/etc/resolv.conf is already configured for ${PN}"
	else
		if [[ -e resolv.conf ]] ; then
			einfo "Your existing resolv.conf is will be mapped to an"
			einfo "interface called \"dummy\" in resolvconf. This will"
			einfo "disappear when you reboot."
			cp resolv.conf resolvconf/run/resolv.conf
			[[ ! -d resolvconf/run/interfaces ]] \
				&& mkdir resolvconf/run/interfaces
			cp resolv.conf resolvconf/run/interfaces/dummy
			echo "dummy" > resolvconf/run/add_order
		fi
		rm -f resolv.conf
		ln -snf resolvconf/run/resolv.conf .
		einfo "${ROOT}/etc/resolv.conf is now correctly configured for ${PN}"
	fi
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/openresolv/openresolv-1.3.ebuild,v 1.1 2008/02/18 19:54:54 welp Exp $

inherit eutils

DESCRIPTION="A framework for managing DNS information"
HOMEPAGE="http://roy.marples.name/node/343"
SRC_URI="http://roy.marples.name/${PN}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND="!net-dns/resolvconf-gentoo
	!<net-dns/dnsmasq-2.40-r1"
RDEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "Failed to install"
}

pkg_postinst() {
	if [ ! -"L ${ROOT}/etc/resolv.conf" ] \
		|| [ "$(readlink "${ROOT}/etc/resolv.conf")" != \
		"resolvconf/run/resolv.conf" ] ; then
		ewarn "resolvconf requires ${ROOT}etc/resolv.conf to be a symbolic"
		ewarn "to resolvconf/run/resolv.conf"
		ewarn "To set this up automatically type"
		ewarn "   emerge --config =${PF}"
	fi
}

pkg_config() {
	cd "${ROOT}/etc"
	if [ -L resolv.conf -a "$(readlink resolv.conf)" = \
		"resolvconf/run/resolv.conf" ] ; then
		einfo "${ROOT}etc/resolv.conf is already configured for ${PN}"
	else
		if [ -e resolv.conf ] ; then
			einfo "Your existing resolv.conf is will be mapped to an"
			einfo "interface called \"dummy\" in resolvconf. This will"
			einfo "disappear when you reboot."
			cp resolv.conf resolvconf/run/resolv.conf
			[ ! -d resolvconf/run/interfaces ] \
				&& mkdir resolvconf/run/interfaces
			cp resolv.conf resolvconf/run/interfaces/dummy
			echo "dummy" > resolvconf/run/add_order
		fi
		rm -f resolv.conf
		ln -snf resolvconf/run/resolv.conf .
		einfo "${ROOT}etc/resolv.conf is now correctly configured for ${PN}"
	fi
}

pkg_postrm() {
	# If we are totally removed but still configured, then replace
	# /etc/resolv.conf with a real file
	cd "${ROOT}"/etc
	[ -L resolv.conf ] || return 0
	if [ -e resolv.conf ]; then
		[ "$(readlink resolv.conf)" = "resolvconf/run/resolv.conf" ] || return 0
		rm resolv.conf
		cp resolvconf/run/resolv.conf .
	elif [ -e /var/run/resolvconf/resolv.conf ]; then
		rm resolv.conf
		cp /var/run/resolvconf/resolv.conf .
	fi
}

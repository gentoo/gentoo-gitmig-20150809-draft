# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/openresolv/openresolv-3.0.ebuild,v 1.2 2009/05/06 15:57:23 lack Exp $

inherit eutils

DESCRIPTION="A framework for managing DNS information"
HOMEPAGE="http://roy.marples.name/projects/openresolv"
SRC_URI="http://roy.marples.name/downloads/${PN}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND="!net-dns/resolvconf-gentoo
	!<net-dns/dnsmasq-2.40-r1"
RDEPEND=""

pkg_setup() {
	export PREFIX=
}

src_install() {
	emake DESTDIR="${D}" install
	exeinto /libexec/resolvconf/
	doexe "${FILESDIR}/pdnsd"
}

pkg_postinst() {
	einfo "${PN}-3.0 has a new configuration file /etc/resolvconf.conf"
	einfo "instead of mini files in different directories."
	einfo "You should configure /etc/resolvconf.conf if you use a resolver"
	einfo "other than libc."
}

pkg_config() {
	if [ "${ROOT}" != "/" ]; then
		eerror "We cannot configure unless \$ROOT=/"
		return 1
	fi

	if [ -n "$(resolvconf -l)" ]; then
		einfo "${PN} already has DNS information"
	else
		ebegin "Copying /etc/resolv.conf to resolvconf -a dummy"
		resolvconf -a dummy </etc/resolv.conf
		eend $? || return $?
		einfo "The dummy interface will disappear when you next reboot"
	fi
}

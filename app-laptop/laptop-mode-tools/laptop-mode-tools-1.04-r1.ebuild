# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/laptop-mode-tools/laptop-mode-tools-1.04-r1.ebuild,v 1.1 2005/03/25 19:05:33 brix Exp $

inherit linux-info

MY_P=${PN}_${PV}

DESCRIPTION="Linux kernel laptop_mode user-space utilities"

HOMEPAGE="http://www.xs4all.nl/~bsamwel/laptop_mode/tools/"
SRC_URI="http://www.xs4all.nl/~bsamwel/laptop_mode/tools/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="acpi apm"

DEPEND="acpi? ( sys-power/acpid )
		apm? ( sys-apps/apmd )"

pkg_setup() {
	linux-info_pkg_setup

	if [ ${KV_MAJOR} -eq 2 -a ${KV_MINOR} -eq 6 -a ${KV_PATCH} -lt 6 ]; then
		eerror "${P} requires kernel version 2.6.6 or newer."
		die "${P} requires kernel version 2.6.6 or newer"
	elif [ ${KV_MAJOR} -eq 2 -a ${KV_MINOR} -eq 4 -a ${KV_PATCH} -lt 23 ]; then
		eerror "${P} requires kernel version 2.4.23 or newer."
		die "${P} requires kernel version 2.4.23 or newer"
	fi
}

src_install() {
	dosbin usr/sbin/laptop_mode

	insinto /etc/laptop-mode
	doins etc/laptop-mode/laptop-mode.conf

	newinitd ${FILESDIR}/${P}.init laptop_mode

	doman man/*

	dodoc Documentation/laptop-mode.txt README

	if useq acpi; then
		insinto /etc/acpi/events/
		doins etc/acpi/events/*

		exeinto /etc/acpi/actions/
		doexe etc/acpi/actions/*
	fi

	if useq apm; then
		exeinto /etc/apm/event.d/
		doexe etc/apm/event.d/*
	fi
}

pkg_postinst() {
	if ! useq acpi && ! useq apm; then
		ewarn
		ewarn "Without USE=\"acpi\" or USE=\"apm\" ${PN} can not"
		ewarn "automatically disable laptop_mode on low battery."
		ewarn
		ewarn "This means you can lose up to 10 minutes of work if running"
		ewarn "out of battery while laptop_mode is enabled."
		ewarn
		ewarn "Please see /usr/share/doc/${PF}/laptop-mode.txt.gz for further"
		ewarn "information."
		ewarn
	fi
}

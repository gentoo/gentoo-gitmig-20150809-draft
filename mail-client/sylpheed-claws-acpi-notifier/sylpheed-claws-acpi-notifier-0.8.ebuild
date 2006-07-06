# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-acpi-notifier/sylpheed-claws-acpi-notifier-0.8.ebuild,v 1.2 2006/07/06 23:19:32 genone Exp $

inherit eutils

MY_PN="${PN#sylpheed-claws-}"
MY_PN="${MY_PN/-/_}"
MY_P="${MY_PN}-${PV}"
SC_BASE="2.0.0"
SC_BASE_NAME="sylpheed-claws-extra-plugins-${SC_BASE}"

DESCRIPTION="This plugin enables mail notification via LEDs on some laptops."
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="mirror://sourceforge/sylpheed-claws/${SC_BASE_NAME}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-${SC_BASE}"

S="${WORKDIR}/${SC_BASE_NAME}/${MY_P}"

src_install() {
	pwd
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}usr/lib*/sylpheed-claws/plugins/*.{a,la}
}

pkg_postinst() {
	PROC_IFACES="/proc/driver/acerhk/led /proc/acpi/asus/mled /proc/acpi/ibm/led"

	local procfile
	local message_shown=false

	echo
	for procfile in ${PROC_IFACES}; do
		if [[ -f ${procfile} ]]; then
			elog "Make sure ${procfile} is writable by users of this plugin."
			message_shown=true
		fi
	done
	if ! $message_shown; then
		elog "To use this plugin, you will have to find the /proc interface"
		elog "that controls your LED. Whatever it is, make sure it's writable"
		elog "by users who will run this plugin."
	fi
	echo
}

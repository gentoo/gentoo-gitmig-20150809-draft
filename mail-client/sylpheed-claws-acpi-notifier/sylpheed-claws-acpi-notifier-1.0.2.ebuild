# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-acpi-notifier/sylpheed-claws-acpi-notifier-1.0.2.ebuild,v 1.2 2006/07/06 23:19:32 genone Exp $

inherit eutils

MY_PN="${PN#sylpheed-claws-}"
MY_PN="${MY_PN/-/_}"
MY_P="${MY_PN}-${PV}"
SC_BASE="2.3.0"
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
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}usr/lib*/sylpheed-claws/plugins/*.{a,la}
}

pkg_postinst() {
	PROC_IFACES="$(echo /proc/acpi/{asus/mled,ibm/led,acer/mailled}) /proc/driver/acerhk/led"

	local procfile
	local message_shown=false

	for procfile in ${PROC_IFACES}; do
		if [[ -f ${procfile} ]]; then
			elog "Make sure ${procfile} is writable by users of this plugin."
			message_shown=true
		fi
	done
}

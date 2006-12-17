# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw3945d/ipw3945d-1.7.22-r4.ebuild,v 1.2 2006/12/17 21:46:35 phreak Exp $

inherit eutils

DESCRIPTION="Regulatory daemon for the Intel PRO/Wireless 3945ABG miniPCI express adapter"
HOMEPAGE="http://www.bughost.org/ipw3945/"
SRC_URI="http://www.bughost.org/ipw3945/daemon/${P}.tgz"

LICENSE="ipw3945"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# The daemon is binary only, is setXid, dyn linked,
# and using lazy bindings
RESTRICT="stricter"

IUSE=""
DEPEND=""

pkg_setup() {
	# Create a user for the ipw3945d daemon
	enewuser ipw3945d -1
}

src_install() {
	into /
	use x86 && dosbin x86/ipw3945d
	use amd64 && dosbin x86_64/ipw3945d

	# Give the ipw3945d access to the binary
	fowners ipw3945d:root /sbin/ipw3945d
	fperms 04450 /sbin/ipw3945d

	keepdir /var/run/ipw3945d
	fowners ipw3945d:root /var/run/ipw3945d

	newconfd "${FILESDIR}/${PN}-conf.d" ${PN}
	newinitd "${FILESDIR}/${PN}-init.d" ${PN}

	insinto /etc/modules.d
	newins "${FILESDIR}/${P}-modprobe.conf" ${PN}

	dodoc README.${PN}
}

pkg_postinst() {
	# Update the modules.d cache
	if [ -f "${ROOT}/etc/modules.d/${PN}" ] ; then
		${ROOT}/sbin/modules-update --force
	fi
	einfo "The ipw3945 daemon is now started by udev. The daemon should be"
	einfo "brought up automatically."
}

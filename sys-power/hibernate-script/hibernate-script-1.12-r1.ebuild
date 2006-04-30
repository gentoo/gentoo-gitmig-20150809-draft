# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/hibernate-script/hibernate-script-1.12-r1.ebuild,v 1.2 2006/04/30 17:49:34 brix Exp $

inherit eutils

# The following works with both pre-releases and releases
MY_P=${PN}-${PV/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Hibernate script supporting multiple suspend methods"

HOMEPAGE="http://www.suspend2.net"
SRC_URI="http://www.suspend2.net/downloads/all/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

IUSE="logrotate"

DEPEND="sys-apps/sed"
RDEPEND="logrotate? ( app-admin/logrotate )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${P}-misc.patch

	# remove obsolete swsusp2_15 scriptlet
	rm -f ${S}/scriptlets.d/swsusp2_15

	sed -i \
		-e "s:^# \(Distribution\).*:\1 gentoo:" \
		-e "s:/usr/local::" \
		${S}/hibernate.conf

	sed -i \
		-e "s:^# \(Distribution\).*:\1 gentoo:" \
		${S}/ram.conf
}

src_install() {
	BASE_DIR=${D} PREFIX=/usr MAN_DIR=${D}/usr/share/man \
		${S}/install.sh

	# hibernate-ram will default to using ram.conf
	dosym /usr/sbin/hibernate /usr/sbin/hibernate-ram

	newinitd ${S}/init.d/hibernate-cleanup.sh hibernate-cleanup

	# other ebuilds can install scriplets to this dir
	keepdir /etc/hibernate/scriptlets.d/

	dodoc CHANGELOG README SCRIPTLET-API

	if use logrotate; then
		insinto /etc/logrotate.d
		newins logrotate.d-hibernate-script hibernate-script
	fi
}

pkg_postinst() {
	einfo
	einfo "You should run the following command to invalidate"
	einfo "suspend images on a clean boot."
	einfo
	einfo "  # rc-update add hibernate-cleanup boot"
	einfo
	einfo "See /usr/share/doc/${PF}/README.gz for further details."
	einfo
	einfo "Please note that you will need to manually emerge any utilities"
	einfo "(radeontool, vbetool, ...) enabled in the configuration files,"
	einfo "should you wish to use them."
	einfo
}

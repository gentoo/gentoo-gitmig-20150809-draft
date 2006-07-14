# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/hibernate-script/hibernate-script-1.93-r1.ebuild,v 1.1 2006/07/14 06:22:38 phreak Exp $

inherit eutils

DESCRIPTION="Hibernate script supporting multiple suspend methods"
HOMEPAGE="http://www.suspend2.net/"
SRC_URI="http://www.suspend2.net/downloads/all/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="logrotate vim"

DEPEND="sys-apps/sed"
RDEPEND="logrotate? ( app-admin/logrotate )"

src_unpack() {
	unpack ${A}

	cd "${S}"

	# remove obsolete swsusp2_15 scriptlet
	rm -f ${S}/scriptlets.d/swsusp2_15

	epatch "${FILESDIR}"/${P}-last_result.patch
	epatch "${FILESDIR}"/${P}-gentoo.patch
	ebegin "Applying ${P}-common.conf.patch"
	sed -i \
		-e "s:^# \(Distribution\).*:\1 gentoo:" \
		"${S}"/common.conf
	eend $?

	ebegin "Applying ${P}-suspend2.conf.patch"
	sed -i \
		-e "s:/usr/local::" \
		"${S}"/suspend2.conf
	eend $?
}

src_install() {
	BASE_DIR="${D}" PREFIX=/usr MAN_DIR="${D}"/usr/share/man \
		"${S}"/install.sh

	# hibernate-ram will default to using ram.conf
	dosym /usr/sbin/hibernate /usr/sbin/hibernate-ram

	newinitd ${S}/init.d/hibernate-cleanup.sh hibernate-cleanup

	# other ebuilds can install scriplets to this dir
	keepdir /etc/hibernate/scriptlets.d/

	if use vim; then
		insinto /usr/share/vim/vimfiles
		doins hibernate.vim
	fi

	dodoc CHANGELOG README SCRIPTLET-API hibernate.vim

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
	einfo "Starting with hibernate-script-1.90 the configuration files have"
	einfo "been reordered and split into method specific files. Make sure you"
	einfo "update your /etc/hibernate/ configuration files accordingly."
	einfo
}

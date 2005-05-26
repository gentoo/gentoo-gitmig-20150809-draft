# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/hibernate-script/hibernate-script-1.07.ebuild,v 1.4 2005/05/26 12:47:02 brix Exp $

inherit eutils

# The following works with both pre-releases and releases
MY_P=${PN}-${PV/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Hibernate script for suspend-to-ram and suspend-to-disk"

HOMEPAGE="http://www.suspend2.net"
SRC_URI="http://www.suspend2.net/downloads/all/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

IUSE=""

DEPEND="sys-apps/sed"
RDEPEND=""

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	# use /sys/power/state instead of swsusp2
	sed -i \
		-e "s:^\(UseSwsusp2\):# \1:" \
		-e "s:^\(Reboot\):# \1:" \
		-e "s:^\(EnableEscape\):# \1:" \
		-e "s:^\(DefaultConsoleLevel\):# \1:" \
		-e "s:^# \(PowerdownMethod shutdown\):\1:" \
		-e "s:^# \(UseSysfsPowerState\) mem:\1 disk:" \
		${S}/hibernate.conf

	# this 'hack' is needed in most cases
	sed -i -e "s:^# \(SwitchToTextMode\):\1:" \
		${S}/hibernate.conf
}

src_install() {
	BASE_DIR=${D} PREFIX=/usr MAN_DIR=${D}/usr/share/man \
		${S}/install.sh

	# hibernate-ram will default to using ram.conf
	dosym /usr/sbin/hibernate /usr/sbin/hibernate-ram

	newinitd ${S}/init.d/hibernate-cleanup.sh hibernate-cleanup

	# other ebuilds can install scriplets to this dir
	keepdir /etc/hibernate/scriptlets.d/

	dodoc CHANGELOG README SCRIPTLET-API TODO
}

pkg_postinst() {
	einfo
	einfo "The /etc/hibernate/sleep.conf file has been moved to"
	einfo "/etc/hibernate/ram.conf to follow upstream."
	einfo
	einfo "If you use Software Suspend 2 you should run"
	einfo "  rc-update add hibernate-cleanup boot"
	einfo "to invalidate suspend images on a clean boot. See"
	einfo "/usr/share/doc/${PF}/README.gz for further details."
	einfo
}

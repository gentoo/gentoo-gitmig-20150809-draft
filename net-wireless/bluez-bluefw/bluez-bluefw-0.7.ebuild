# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-bluefw/bluez-bluefw-0.7.ebuild,v 1.4 2003/09/07 00:19:18 msterret Exp $

DESCRIPTION="bluetooth firmware downloader"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="sys-apps/hotplug
		>=net-wireless/bluez-kernel-2.3
		>=net-wireless/bluez-libs-2.2"
S="${WORKDIR}/${P}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	# in order for hotplug to work, the id string from bluefw.usermap has
	# to be added to usb.usermap
	# unfortunately this isn't conveniently reversable
	if [[ ! `grep ^bluefw /etc/hotplug/usb.usermap` ]]; then
		cat /etc/hotplug/usb/bluefw.usermap >> /etc/hotplug/usb.usermap
	fi
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openct/openct-0.5.0.ebuild,v 1.6 2004/08/03 01:27:31 vapier Exp $

inherit eutils

DESCRIPTION="OpenCT is a library for accessing smart card terminals."
HOMEPAGE="http://opensc.org/"
SRC_URI="http://opensc.org/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="usb"

RDEPEND="virtual/libc
	usb? (	>=dev-libs/libusb-0.1.7
		>=sys-apps/hotplug-20030805-r1 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.7
	sys-apps/shadow"

pkg_setup() {
	enewgroup openct
}

src_compile() {
	econf --localstatedir=/var || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	insinto /etc
	doins etc/openct.conf || die
	if use usb ; then
		insinto /etc/hotplug/usb
		doins etc/openct.usermap || die
		exeinto /etc/hotplug/usb
		newexe etc/hotplug.openct openct || die
	fi

	exeinto /etc/init.d
	newexe ${FILESDIR}/openct.rc openct || die

	diropts -m0750 -gopenct
	dodir /var/run/openct

	dodoc ANNOUNCE AUTHORS NEWS README TODO
	dohtml doc/openct.{html,css}
}

pkg_postinst() {
	einfo "You need to edit /etc/openct.conf to enable serial readers."
	einfo
	einfo "To use hotplugging (USB readers) your kernel has to be compiled"
	einfo "with CONFIG_HOTPLUG enabled and sys-apps/hotplug must be emerged."
	einfo
	einfo "You should add \"openct\" to your default runlevel. To do so"
	einfo "type \"rc-update add openct default\"."
	einfo
	einfo "You need to be a member of the (newly created) group openct to"
	einfo "access smart card readers connected to this system. Set users'"
	einfo "groups with usermod -G.  root always has access."
}

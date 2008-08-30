# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openct/openct-0.5.0.ebuild,v 1.16 2008/08/30 04:47:45 dragonheart Exp $

inherit eutils

DESCRIPTION="library for accessing smart card terminals"
HOMEPAGE="http://opensc.org/"
SRC_URI="http://opensc.org/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="usb"

RDEPEND="
	usb? (	>=dev-libs/libusb-0.1.7
		>=sys-apps/hotplug-20030805-r1 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.7"

pkg_setup() {
	enewgroup openct
}

src_compile() {
	econf --localstatedir=/var || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	insinto /etc
	doins etc/openct.conf || die
	if use usb ; then
		insinto /etc/hotplug/usb
		doins etc/openct.usermap || die
		exeinto /etc/hotplug/usb
		newexe etc/hotplug.openct openct || die
	fi

	newinitd "${FILESDIR}"/openct.rc openct || die

	diropts -m0750 -gopenct
	dodir /var/run/openct

	dodoc ANNOUNCE AUTHORS NEWS README TODO
	dohtml doc/openct.{html,css}
}

pkg_postinst() {
	elog "You need to edit /etc/openct.conf to enable serial readers."
	elog
	elog "To use hotplugging (USB readers) your kernel has to be compiled"
	elog "with CONFIG_HOTPLUG enabled and sys-apps/hotplug must be emerged."
	elog
	elog "You should add \"openct\" to your default runlevel. To do so"
	elog "type \"rc-update add openct default\"."
	elog
	elog "You need to be a member of the (newly created) group openct to"
	elog "access smart card readers connected to this system. Set users'"
	elog "groups with usermod -G.  root always has access."
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lcd4linux/lcd4linux-0.9.9.ebuild,v 1.11 2005/01/25 15:27:45 greg_g Exp $

DESCRIPTION="system and ISDN information is shown on an external display or in a X11 window"
HOMEPAGE="http://lcd4linux.sourceforge.net/"
SRC_URI="mirror://sourceforge/lcd4linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="kde pda png X usb"

DEPEND="png? ( media-libs/libpng
	sys-libs/zlib
	media-libs/gd )"

src_compile() {
	local myconf

	use png || myconf=",!PNG"
	use pda || myconf="${myconf},!PalmPilot"
	use X || myconf="${myconf},!X11"
	use usb || myconf="${myconf},!USBLCD"

	econf \
		--sysconfdir=/etc/lcd4linux \
		--with-drivers="all${myconf},!PNG" || die "econf failed"

	emake || die
}

src_install() {
	CONFIG_PROTECT="${CONFIG_PROTECT} /etc/lcd4linux"
	einstall

	insinto /etc/lcd4linux
	cp lcd4linux.conf.sample lcd4linux.conf
	insopts -o root -g root -m 0600
	doins lcd4linux.conf
	dodoc README* NEWS INSTALL TODO CREDITS FAQ
	dodoc lcd4linux.conf.sample lcd4linux.kdelnk lcd4linux.xpm

	if use kde ; then
		insinto /etc/lcd4linux
		insopts -o root -g root -m 0600
		doins lcd4kde.conf
		insinto /usr/share/applnk/apps/System
		doins lcd4linux.kdelnk
		insinto /usr/share/pixmaps
		doins lcd4linux.xpm
		touch ${D}/etc/lcd4linux/lcd4X11.conf
	fi
}

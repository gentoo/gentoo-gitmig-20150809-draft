# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lcd4linux/lcd4linux-0.9.11.ebuild,v 1.12 2006/12/06 11:31:16 jokey Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
inherit eutils autotools

DESCRIPTION="Shows system and ISDN information on an external display or in a X11 window"
HOMEPAGE="http://ssl.bulix.org/projects/lcd4linux/"
SRC_URI="mirror://sourceforge/lcd4linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="kde pda png X usb"

RDEPEND="sys-libs/ncurses
	x11-libs/libX11
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	x11-libs/libXt"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-modular-x.patch"
	eautoreconf
}

src_compile() {
	local myconf

	use png || myconf=",!PNG"
	use pda || myconf="${myconf},!PalmPilot"
	use X   || myconf="${myconf},!X11"
	use usb || myconf="${myconf},!USBLCD"

	econf \
		--sysconfdir=/etc/lcd4linux \
		--with-drivers="all${myconf}" || die "econf failed"

	emake || die
}

src_install() {
	CONFIG_PROTECT="${CONFIG_PROTECT} /etc/lcd4linux"
	einstall

	insinto /etc/lcd4linux
	newins lcd4linux.conf.sample lcd4linux.conf
	insopts -o root -g root -m 0600
	dodoc README* NEWS TODO CREDITS FAQ
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

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lcd4linux/lcd4linux-0.9.10.ebuild,v 1.3 2004/04/06 04:19:22 vapier Exp $

inherit eutils

DESCRIPTION="system and ISDN information is shown on an external display or in a X11 window."
HOMEPAGE="http://lcd4linux.sourceforge.net/"
SRC_URI="mirror://sourceforge/lcd4linux/${P}.tar.gz
	http://branched.modestolan.com/${P}-cf634.diff"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="kde pda png X usb"

DEPEND="png? ( media-libs/libpng
	sys-libs/zlib
	media-libs/libgd )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${P}-cf634.diff
}

src_compile() {
	local myconf
	use png || myconf=",!PNG"
	use pda || myconf="${myconf},!PalmPilot"
	use X || myconf="${myconf},!X11"
	use usb || myconf="${myconf},!USBLCD"
	econf \
		--sysconfdir=/etc/lcd4linux \
		--with-drivers="all${myconf},!PNG" \
		|| die

	emake || die
}

src_install() {
	CONFIG_PROTECT="${CONFIG_PROTECT} /etc/lcd4linux"
	einstall || die

	insinto /etc/lcd4linux
	cp lcd4linux.conf.sample lcd4linux.conf
	insopts -o root -g root -m 0600
	doins lcd4linux.conf
	dodoc README* NEWS COPYING INSTALL TODO CREDITS FAQ
	dodoc lcd4linux.conf.sample lcd4linux.kdelnk lcd4linux.xpm

	if use kde ; then
		insinto /etc/lcd4linux
		insopts -o root -g root -m 0600
		doins lcd4kde.conf
		insinto ${KDEDIR}/share/applnk/apps/System
		doins lcd4linux.kdelnk
		insinto ${KDEDIR}/share/icons
		doins lcd4linux.xpm
		touch ${D}/etc/lcd4linux/lcd4X11.conf
	fi
}

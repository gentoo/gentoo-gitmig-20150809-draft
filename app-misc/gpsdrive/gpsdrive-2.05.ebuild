# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gpsdrive/gpsdrive-2.05.ebuild,v 1.3 2004/04/06 04:18:31 vapier Exp $

inherit eutils

DESCRIPTION="displays GPS position on a map"
HOMEPAGE="http://gpsdrive.kraftvoll.at"
SRC_URI="http://gpsdrive.kraftvoll.at/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

DEPEND="sys-devel/gettext
	>=x11-libs/gtk+-2.0
	>=dev-libs/libpcre-4.2"

src_unpack() {
	unpack ${A}
	cd ${S}

	# allow higher serial port speeds, Mina Naguib <webmaster@topfx.com>
	epatch ${FILESDIR}/gpsd.higher_serial_speeds.patch
}

src_compile() {
	econf `use_enable nls` || die
	emake || die "compile failed"
}

src_install() {
	make DESTDIR=${D} install || die
}

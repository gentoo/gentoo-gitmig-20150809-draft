# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/i8086emu/i8086emu-0.9.1.ebuild,v 1.1 2004/03/29 08:16:51 dragonheart Exp $

inherit eutils

DESCRIPTION="Emulator for the Intel 8086 microprocessor"
HOMEPAGE="http://i8086emu.sourceforge.net"
SRC_URI="mirror://sourceforge/i8086emu/i8086emu-src-${PV}.tar.bz2"
RESTRICT="nomirror"

S=${WORKDIR}/i8086emu-src-${PV}
LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~x86 ~alpha ~amd64"
KEYWORDS="~x86"
IUSE="X"

RDEPEND="sys-libs/ncurses
	virtual/glibc
	X? ( dev-libs/glib
		dev-libs/atk
		media-libs/fontconfig
		x11-libs/pango
		virtual/x11
		media-libs/freetype
		sys-libs/zlib
		dev-libs/expat
		>=x11-libs/gtk+-2.0.0 )"

DEPEND="${RDEPEND}
	sys-devel/gcc
	sys-devel/autoconf
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {

	local myconf
	use X || myconf="usegtk=0"

	econf ${myconf} || die "Failed to configure"
	emake || die "Failed to make"
}

src_install() {

	emake DESTDIR=${D} infodir=/usr/share/doc/${P} examplesdir=/usr/share/doc/${P}/examples install

}

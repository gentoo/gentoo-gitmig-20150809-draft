# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/tvtime/tvtime-0.9.10-r1.ebuild,v 1.5 2004/01/12 19:23:47 max Exp $

DESCRIPTION="High quality television application for use with video capture cards."
HOMEPAGE="http://tvtime.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="directfb sdl nls"

DEPEND="virtual/x11
	>=media-libs/freetype-2
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=dev-libs/libxml2-2.5.11
	directfb? ( >=dev-libs/DirectFB-0.9 )
	sdl? ( >=media-libs/libsdl-1.2 )"

src_unpack() {
	unpack ${A} && cd "${S}"
	epatch "${FILESDIR}/${P}-make.patch"
}

src_compile() {
	local myconf="--with-fifogroup=video --localstatedir=/var"
	myconf="${myconf} `use_enable nls`"
	myconf="${myconf} `use_with directfb`"
	myconf="${myconf} `use_with sdl` `use_enable sdl sdltest`"

	econf ${myconf}
	emake || die "compile problem"
}

src_install () {
	einstall localstatedir="${D}/var"
	keepdir /var/run/tvtime
	fperms 0775 /var/run/tvtime

	dohtml docs/html/*
	dodoc ChangeLog AUTHORS NEWS BUGS README README.UPGRADING COPYING \
		data/COPYING.* docs/example.lircrc
}

pkg_postinst() {
	einfo "A default setup for ${PN} has been saved as"
	einfo "/etc/tvtime/tvtime.xml. You may need to modify it"
	einfo "for your needs."
	einfo
	einfo "Detailed information on ${PN} setup can be"
	einfo "found at ${HOMEPAGE}help.html"
	echo
}

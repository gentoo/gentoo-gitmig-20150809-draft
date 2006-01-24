# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spectemu/spectemu-0.99.3.ebuild,v 1.5 2006/01/24 23:55:49 vanquirius Exp $

### Several versions of specemu exist,  xspect & vgaspect, utilising X11
### and/or svgalib. libreadline provides optional runtime features.
### The ./configure script automagically figures out which binaries to build
### so the run/compiletime dependancies here are use dependant

DESCRIPTION="48k ZX Spectrum Emulator"
HOMEPAGE="http://kempelen.iit.bme.hu/~mszeredi/spectemu/spectemu.html"
SRC_URI="http://www.inf.bme.hu/~mszeredi/spectemu/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="X readline svga"

#X? ( virtual/x11 )

DEPEND="X? ( || (
	( >=x11-proto/xf86vidmodeproto-2.2.2
	>=x11-proto/xextproto-7.0.2
	>=x11-proto/xproto-7.0.4
	>=x11-libs/libX11-1.0.0
	>=x11-libs/libXext-1.0.0
	>=x11-libs/libXxf86vm-1.0.0 )
	virtual/x11 )
	)
	readline? ( sys-libs/readline )"
RDEPEND="svga? ( media-libs/svgalib )"

src_compile() {
	local myflags
	use X || myflags="${myflags} --with-x=no"
	use readline || myflags="${myflags} --without-readline"

	myflags="${myflags} --mandir=${D}/usr/share/man/"

	econf ${myflags} || die "Spectemu ./configure failed"
	emake || die "Spectemu make failed"
}

src_install() {
	einstall || die
}


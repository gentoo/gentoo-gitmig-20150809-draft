# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spectemu/spectemu-0.99.3.ebuild,v 1.4 2005/09/07 19:44:14 voxus Exp $

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

DEPEND="X? ( virtual/x11 )
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
	einstall
}


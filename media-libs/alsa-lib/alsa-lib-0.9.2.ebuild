# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-0.9.2.ebuild,v 1.3 2003/04/24 22:09:19 agenkin Exp $

inherit libtool

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"

SLOT="0"
KEYWORDS="x86 ~ppc ~alpha"
LICENSE="GPL-2 LGPL-2.1"

DEPEND="virtual/glibc
	>=sys-devel/automake-1.7.2
	>=sys-devel/autoconf-2.57-r1"

SRC_URI="ftp://ftp.alsa-project.org/pub/lib/${P}.tar.bz2"
S=${WORKDIR}/${P}

src_compile() {                           
	elibtoolize
	econf || die "./configure failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die

	#This alsa version does not provide libasound.so.1
	#Without this library just about everything even remotely
	#linked to previous versions of alsa-lib will break.
	#Fortunately, libasound.so.2 seems to be backwards
	#compatible with libasound.so.2 and a simple link
	#fixes the problem (fingers crossed)
	dosym /usr/lib/libasound.so.2 /usr/lib/libasound.so.1
	
	dodoc ChangeLog COPYING TODO 
}

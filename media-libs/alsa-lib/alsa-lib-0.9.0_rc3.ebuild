# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-0.9.0_rc3.ebuild,v 1.1 2002/08/16 02:43:53 agenkin Exp $

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"
LICENSE="GPL"

DEPEND="virtual/glibc 
	~media-sound/alsa-driver-0.9.0_rc3"

MY_P=${P/_rc/rc}
S=${WORKDIR}/${MY_P}

SRC_URI="ftp://ftp.alsa-project.org/pub/lib/${MY_P}.tar.bz2"

SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {                           
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		|| die "./configure failed"
	make || die "Parallel Make Failed"
}

src_install() {
	make DESTDIR=${D} install || die "Installation Failed"

	#This alsa version does not provide libasound.so.1
	#Without this library just about everything even remotely
	#linked to previous versions of alsa-lib will break.
	#Fortunately, libasound.so.2 seems to be backwards
	#compatible with libasound.so.2 and a simple link
	#fixes the problem (fingers crossed)
	dosym /usr/lib/libasound.so.2 /usr/lib/libasound.so.1
	
	dodoc ChangeLog COPYING TODO 
}

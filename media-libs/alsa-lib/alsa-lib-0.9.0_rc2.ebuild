# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-0.9.0_rc2.ebuild,v 1.6 2002/08/14 13:08:09 murphy Exp $

MY_P=${P/_rc/rc}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"

SRC_URI="ftp://ftp.alsa-project.org/pub/lib/${MY_P}.tar.bz2"

DEPEND="virtual/glibc 
	~media-sound/alsa-driver-0.9.0_rc2"

SLOT="0"
LICENSE="GPL"
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

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-1.0.1.ebuild,v 1.3 2004/01/29 03:22:53 agriffis Exp $

inherit libtool

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"

SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~amd64 -sparc ~ia64"
LICENSE="GPL-2 LGPL-2.1"

IUSE="jack"

DEPEND="virtual/glibc
	>=sys-devel/automake-1.7.2
	>=sys-devel/autoconf-2.57-r1
	!ppc? ( jack? ( virtual/jack ) )"

MY_P=${P/_rc/rc}
#SRC_URI="ftp://ftp.alsa-project.org/pub/lib/${MY_P}.tar.bz2"
SRC_URI="mirror://alsaproject/lib/${MY_P}.tar.bz2"
RESTRICT="nomirror"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	# - remove trampolines and text relocations - <solar@gentoo>
	## send this patch upstream after we have tested fully 
	## on the various arches for inclusion in 1.x final
	epatch ${FILESDIR}/${P}-notextrel-notrampoline.patch
}

src_compile() {
	elibtoolize
	econf || die "./configure failed"
	emake || die "make failed"

	if [ -n "`use jack`" ]
	then
		cd ${S}/src/pcm/ext
		make jack || die "make on jack plugin failed"
	fi
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	#This alsa version does not provide libasound.so.1
	#Without this library just about everything even remotely
	#linked to previous versions of alsa-lib will break.
	#Fortunately, libasound.so.2 seems to be backwards
	#compatible with libasound.so.2 and a simple link
	#fixes the problem (fingers crossed)
	dosym /usr/lib/libasound.so.2 /usr/lib/libasound.so.1
	dodoc ChangeLog COPYING TODO

	if [ -n "`use jack`" ]
	then
		cd ${S}/src/pcm/ext
		make DESTDIR=${D} install-jack || die "make install on jack plugin failed"
	fi
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-0.9.8.ebuild,v 1.9 2004/01/29 03:22:53 agriffis Exp $

inherit libtool

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"

SLOT="0"
KEYWORDS="x86 ppc alpha amd64 -sparc ia64"
LICENSE="GPL-2 LGPL-2.1"

IUSE="jack"

DEPEND="virtual/glibc
	>=sys-devel/automake-1.7.2
	>=sys-devel/autoconf-2.57-r1
	!ppc? ( jack? ( virtual/jack ) )"

SRC_URI="mirror://alsaproject/lib/${P}.tar.bz2"
RESTRICT="nomirror"
S=${WORKDIR}/${P}

src_compile() {
	elibtoolize
	econf || die "./configure failed"
	emake || die "make failed"

	if use jack; then
	cd ${S}/src/pcm/ext
	make jack || die "make on jack plugin failed"
		sed -i \
			-e "s:\$(pkglibLTLIBRARIES_INSTALL) \$(INSTALL_STRIP_FLAG):\$(pkglibLTLIBRARIES_INSTALL) \$(INSTALL) \$(INSTALL_STRIP_FLAG):" Makefile || \
		die "make on jack plugin failed"
	fi
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

	if use jack; then
		cd ${S}/src/pcm/ext
		make DESTDIR=${D} install-jack || die "make install on jack plugin failed"
	fi
}

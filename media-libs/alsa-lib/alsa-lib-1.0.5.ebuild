# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-1.0.5.ebuild,v 1.10 2004/11/02 20:09:00 eradicator Exp $

inherit libtool

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"

SLOT="0"
KEYWORDS="x86 ppc ~alpha amd64 -sparc ~ia64 ppc64"
LICENSE="GPL-2 LGPL-2.1"

IUSE="static jack"

RDEPEND="virtual/libc"

DEPEND=">=sys-devel/automake-1.7.2
	>=sys-devel/autoconf-2.57-r1"

PDEPEND="jack? ( =media-plugins/alsa-jack-${PV}* )"

MY_P=${P/_rc/rc}
#SRC_URI="ftp://ftp.alsa-project.org/pub/lib/${MY_P}.tar.bz2"
SRC_URI="mirror://alsaproject/lib/${MY_P}.tar.bz2"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	if use static; then
		mv ${S} ${S}.static
		unpack ${A}

		cd ${S}.static
		elibtoolize
	fi

	cd ${S}
	elibtoolize
}

src_compile() {
	local myconf=""

	econf --enable-static=no --enable-shared=yes || die
	emake || die

	# Can't do both according to alsa docs and bug #48233
	if use static; then
		cd ${S}.static
		econf --enable-static=yes --enable-shared=no || die
		emake || die
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	#This alsa version does not provide libasound.so.1
	#Without this library just about everything even remotely
	#linked to previous versions of alsa-lib will break.
	#Fortunately, libasound.so.2 seems to be backwards
	#compatible with libasound.so.1 and a simple link
	#fixes the problem (fingers crossed)
	dosym /usr/lib/libasound.so.2 /usr/lib/libasound.so.1
	dodoc ChangeLog COPYING TODO

	if use static; then
		cd ${S}.static
		make DESTDIR="${D}" install || die "make install failed"
	fi
}

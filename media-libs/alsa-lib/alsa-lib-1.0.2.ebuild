# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-1.0.2.ebuild,v 1.12 2004/11/02 20:09:00 eradicator Exp $

inherit libtool gnuconfig

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"

SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~amd64 -sparc ~ia64 mips"
LICENSE="GPL-2 LGPL-2.1"

IUSE="jack"

RDEPEND="jack? ( media-sound/jack-audio-connection-kit )"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7.2
	>=sys-devel/autoconf-2.57-r1"

MY_P=${P/_rc/rc}
#SRC_URI="ftp://ftp.alsa-project.org/pub/lib/${MY_P}.tar.bz2"
SRC_URI="mirror://alsaproject/lib/${MY_P}.tar.bz2"
RESTRICT="nomirror"
S=${WORKDIR}/${MY_P}

src_compile() {

	# Allow configure to detect mipslinux systems
	gnuconfig_update

	elibtoolize
	econf || die "./configure failed"
	emake || die "make failed"

	if use jack
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

	if use jack
	then
		cd ${S}/src/pcm/ext
		make DESTDIR=${D} install-jack || die "make install on jack plugin failed"
	fi
}

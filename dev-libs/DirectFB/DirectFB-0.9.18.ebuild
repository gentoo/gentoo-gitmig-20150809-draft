# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.18.ebuild,v 1.1 2003/06/25 13:01:15 lostlogic Exp $

DESCRIPTION="Thin library on top of the Linux framebuffer devices"
SRC_URI="http://www.directfb.org/download/DirectFB/${P}.tar.gz"
HOMEPAGE="http://www.directfb.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="jpeg gif png truetype mpeg mmx sse"

DEPEND="dev-lang/perl
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	mpeg? ( media-libs/libmpeg3 )
	truetype? ( >=media-libs/freetype-2.0.1 )"

src_unpack() {
	unpack ${A}
#	cd ${S}
#	cp configure ${T}
#	sed -e 's:ac_safe=`echo "libmpeg3.h:ac_safe=`echo "libmpeg3/libmpeg3.h:' \
#		-e 's:#include <libmpeg3.h>:#include <libmpeg3/libmpeg3.h>:' \
#		${T}/configure > configure
}

src_compile() {
	econf \
		`use_enable mmx` \
		`use_enable sse` \
		`use_enable mpeg libmpeg3` \
		`use_enable jpeg` \
		`use_enable png` \
		`use_enable gif` \
		`use_enable truetype freetype` \
		 || die

	use mpeg && { \
		cd ${S}/interfaces/IDirectFBVideoProvider
		cp idirectfbvideoprovider_libmpeg3.c ${T}
	
		sed s':#include <libmpeg3.h>:#include <libmpeg3/libmpeg3.h>:' \
			${T}/idirectfbvideoprovider_libmpeg3.c > \
				idirectfbvideoprovider_libmpeg3.c
		cd ${S}
	}

	# add extra -lstdc++ so libpng/libflash link correctly
	make LDFLAGS="${LDFLAGS} -lstdc++" || die
}

src_install() {
	insinto /etc
	doins fb.modes

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
	dohtml -r docs/html
}

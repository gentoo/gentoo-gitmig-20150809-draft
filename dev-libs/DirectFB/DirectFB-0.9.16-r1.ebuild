# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.16-r1.ebuild,v 1.4 2003/06/13 12:57:42 seemant Exp $

IUSE="jpeg gif png truetype mpeg mmx sse"

S=${WORKDIR}/${P}
DESCRIPTION="Thin library on top of the Linux framebuffer devices"
SRC_URI="http://www.directfb.org/download/DirectFB/${P}.tar.gz"
HOMEPAGE="http://www.directfb.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND=">=sys-apps/sed-4
	dev-lang/perl
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	mpeg? ( media-libs/libmpeg3 )
	truetype? ( >=media-libs/freetype-2.0.1 )"


PDEPEND="=dev-libs/DirectFB-extra-${PV}*"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:ac_safe=`echo "libmpeg3.h:ac_safe=`echo "libmpeg3/libmpeg3.h:' \
		-e 's:#include <libmpeg3.h>:#include <libmpeg3/libmpeg3.h>:' \
		configure
}

src_compile() {
	local myconf=""
	
	# Bug in the ./configure script that breaks if you
	# have --enable-mmx
	use mmx \
		&& myconf="${myconf} --enable-mmx" \
		|| myconf="${myconf} --disable-mmx"

	use sse \
		&& myconf="${myconf} --enable-sse" \
		|| myconf="${myconf} --disable-sse"

	use mpeg \
		&& myconf="${myconf} --enable-libmpeg3" \
		|| myconf="${myconf} --disable-libmpeg3"
	
	use jpeg \
		&& myconf="${myconf} --enable-jpeg" \
		|| myconf="${myconf} --disable-jpeg"

	use png \
		&& myconf="${myconf} --enable-png" \
		|| myconf="${myconf} --disable-png"

	use gif \
		&& myconf="${myconf} --enable-gif" \
		|| myconf="${myconf} --disable-gif"

	use truetype \
		&& myconf="${myconf} --enable-freetype" \
		|| myconf="${myconf} --disable-freetype"


	econf ${myconf} || die

	use mpeg && ( \
		cd ${S}/interfaces/IDirectFBVideoProvider
		cp idirectfbvideoprovider_libmpeg3.c ${T}
	
		sed s':#include <libmpeg3.h>:#include <libmpeg3/libmpeg3.h>:' \
			${T}/idirectfbvideoprovider_libmpeg3.c > \
				idirectfbvideoprovider_libmpeg3.c
		cd ${S}
	)

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

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg3/libmpeg3-1.5.ebuild,v 1.2 2002/07/11 06:30:39 drobbins Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="An mpeg library for linux"
SRC_URI="http://heroinewarrior.com/${P}.tar.gz"
HOMEPAGE="http://heroinewarrior.com/libmpeg3.php3"

RDEPEND="sys-libs/zlib 
	media-libs/jpeg"

DEPEND="${RDEPEND}
	dev-lang/nasm"

src_compile() {
	
	cp Makefile Makefile.orig

	sed 's:cp $(UTILS) /usr/bin:cp $(UTILS) ${D}/usr/bin:' \
		Makefile.orig > Makefile
	
	export CFLAGS=${CFLAGS}
	make ${myconf} || die
}

src_install () {
	
	dodir /usr/bin
	make install || die
	
	dolib.a ${CHOST%%-*}/libmpeg3.a
	
	insinto /usr/include/libmpeg3/${CHOST%%-*}
	doins *.{h,inc}

	insinto /usr/include/libmpeg3/audio
	doins audio/*.h

	insinto /usr/include/libmpeg3/video
	doins video/*.h

	dohtml docs/*.html

}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvorbis/libvorbis-1.0.1.ebuild,v 1.4 2003/12/19 23:07:18 vapier Exp $

inherit libtool eutils flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="the Ogg Vorbis sound file format library"
SRC_URI="http://www.vorbis.com/files/${PV}/unix/${P}.tar.gz"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

IUSE=""
#IUSE="sse 3dnow"
DEPEND=">=media-libs/libogg-1.0"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~amd64 ~mips"

src_unpack() {
	unpack ${A}

	cd ${S}
#	This patch is not yet compatable with 1.0.1, hopefully a new version will
#	be made available sometime in the near future.
#	if [ `use x86` ] ; then
#		if [ `use sse` ]; then
#			epatch ${FILESDIR}/${PN}-simd.patch
#			# patch doesn't support sse2. See #28439
#			filter-flags "-msse2"
#		fi
#		use 3dnow && append-flags -Dsimd_3dn
#	fi

#	This patch does not appear to be necessary any more...
#	epatch ${FILESDIR}/${PN}-m4.patch || die "Patching failed"
	# Fix a gcc crash.  With the new atexit patch to gcc, it
	# seems it do not handle -mno-ieee-fp too well.
	sed -i -e "s:-mno-ieee-fp::g" configure
}

src_compile() {
	elibtoolize

	# take out -fomit-frame-pointer from CFLAGS if k6-2
	is-flag "-march=k6-3" && filter-flags "-fomit-frame-pointer"
	is-flag "-march=k6-2" && filter-flags "-fomit-frame-pointer"
	is-flag "-march=k6" && filter-flags "-fomit-frame-pointer"

	# filter march, see bug #26463 for details
	filter-flags "-march=pentium?"

	# remove sse2 support #36104
	append-flags -mno-sse2

	./configure --prefix=/usr \
		--host=${CHOST} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dosym /usr/lib/libvorbisfile.so.3.0.0 /usr/lib/libvorbisfile.so.0
	dosym /usr/lib/libvorbisenc.so.2.0.0 /usr/lib/libvorbisenc.so.0

	echo "Removing docs installed by make install"
	rm -rf ${D}/usr/share/doc

	dodoc AUTHORS COPYING README todo.txt
	docinto txt
	dodoc doc/*.txt
	dohtml -r doc
}

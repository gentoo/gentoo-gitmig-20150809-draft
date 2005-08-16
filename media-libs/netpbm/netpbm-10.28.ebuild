# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/netpbm/netpbm-10.28.ebuild,v 1.11 2005/08/16 05:02:45 vapier Exp $

inherit flag-o-matic toolchain-funcs eutils

DESCRIPTION="A set of utilities for converting to/from the netpbm (and related) formats"
HOMEPAGE="http://netpbm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="svga jpeg tiff png zlib"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	tiff? ( >=media-libs/tiff-3.5.5 )
	png? ( >=media-libs/libpng-1.2.1 )
	zlib? ( sys-libs/zlib )
	svga? ( media-libs/svgalib )"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile.config.in Makefile.config

	if use svga ; then
		echo "LINUXSVGAHDR_DIR = /usr/include" >> Makefile.config
		echo "LINUXSVGALIB = /usr/$(get_libdir)/libvga.so" >> Makefile.config
	fi

	if use jpeg ; then
		echo "JPEGLIB = libjpeg.so" >> Makefile.config
	fi

	if use png ; then
		echo "PNGLIB = libpng.so" >> Makefile.config
	fi

	if use tiff ; then
		echo "TIFFLIB = libtiff.so" >> Makefile.config
	fi

	if use zlib ; then
		echo "ZLIB = libz.so" >> Makefile.config
	fi

	# Sparc support ...
	replace-flags "-mcpu=ultrasparc" "-mcpu=v8 -mtune=ultrasparc"
	replace-flags "-mcpu=v9" "-mcpu=v8 -mtune=v9"

	sed -i \
		-e 's:$(CFLAGS):$(CFLAGS) -fPIC:' \
		-e 's:$(LDFLAGS):$(LDFLAGS) -fPIC:' \
		lib/Makefile
	 sed -i -e 's:$(CCOPT):$(CCOPT) -fPIC:' \
	 	lib/util/Makefile

	epatch ${FILESDIR}/${PN}-dSAFER.patch
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	make package pkgdir=${D}/usr/ || die "make package failed"

	if [ "$(get_libdir)" != "lib" ]; then
		mv ${D}/usr/lib ${D}/usr/$(get_libdir)
	fi

	# Fix symlink not being created.
	dosym `basename ${D}/usr/$(get_libdir)/libnetpbm.so.*` /usr/$(get_libdir)/libnetpbm.so

	rm -rf ${D}/usr/bin/doc.url
	rm -rf ${D}/usr/man/web
	rm -rf ${D}/usr/link
	rm -rf ${D}/usr/README
	rm -rf ${D}/usr/VERSION
	rm -rf ${D}/usr/pkginfo
	rm -f ${D}/usr/config_template
	dodir /usr/share
	mv ${D}/usr/man ${D}/usr/share/man

	# Install the maps in /usr/share/netpbm so other programs (like plucker) can
	# use them.  #77797
	mv ${D}/usr/misc ${D}/usr/share/netpbm

	dodoc README
	export GLOBIGNORE='*.html:.*'
	cd doc && \
		dodoc * && \
		dohtml -r . || die "doc install failed"
}

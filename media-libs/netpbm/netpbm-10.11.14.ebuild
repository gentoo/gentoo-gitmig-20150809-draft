# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/netpbm/netpbm-10.11.14.ebuild,v 1.5 2004/01/14 17:45:29 mholzer Exp $

inherit flag-o-matic

DESCRIPTION="A set of utilities for converting to/from the netpbm (and related) formats"
HOMEPAGE="http://netpbm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm ~amd64 ia64"
IUSE="svga"
RESTRICT="nomirror"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.2.1
	svga? ( media-libs/svgalib )"

src_unpack() {
	unpack ${A}
	cd ${S}

	if [ `use svga` ] ; then
		cfg="svga"
	else
		cfg="config"
	fi

	# Sparc support ...
	replace-flags "-mcpu=ultrasparc" "-mcpu=v8 -mtune=ultrasparc"
	replace-flags "-mcpu=v9" "-mcpu=v8 -mtune=v9"

	sed -e "s:-O3:${CFLAGS} -fPIC:" ${FILESDIR}/${PV}/Makefile.${cfg} \
		> Makefile.config || die "Flag replacement failed"
}

src_compile() {
	MAKEOPTS="${MAKEOPTS} -j1"
	emake CC="${CC}" CXX="${CXX}"|| die "emake failed"
}

src_install() {
	make package pkgdir=${D}/usr/ || die "make package failed"

	# Fix symlink not being created.
	dosym `basename ${D}/usr/lib/libnetpbm.so.*` /usr/lib/libnetpbm.so

	dodir /usr/share
	rm -rf ${D}/usr/bin/doc.url
	rm -rf ${D}/usr/man/web
	rm -rf ${D}/usr/link
	rm -rf ${D}/usr/README
	rm -rf ${D}/usr/pkginfo
	mv ${D}/usr/man/ ${D}/usr/share/man

	dodoc README
	export GLOBIGNORE='*.html:.*'
	cd doc && \
		dodoc * && \
		dohtml -r . || die "doc install failed"
}

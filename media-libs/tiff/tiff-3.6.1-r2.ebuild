# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tiff/tiff-3.6.1-r2.ebuild,v 1.4 2004/10/23 07:53:58 mr_bones_ Exp $

inherit eutils

MY_S=${P/tiff-/tiff-v}
MY_P=${PN}-v${PV/_beta/-beta}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Library for manipulation of TIFF (Tag Image File Format) images."
HOMEPAGE="http://www.libtiff.org/"
SRC_URI="ftp://ftp.remotesensing.org/pub/libtiff/${MY_P}.tar.gz
	ftp://ftp.remotesensing.org/libtiff/libtiff-lzw-compression-kit-1.5.tar.gz
	mirror://gentoo/libtiff-3.6.1-alt-bound.patch.bz2
	mirror://gentoo/libtiff-3.6.1-alt-bound-fix2.patch.bz2
	mirror://gentoo/libtiff-3.6.1-chris-bound.patch.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390 ppc-macos ppc64"
IUSE="lzw-tiff"

DEPEND=">=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3-r2"

src_unpack() {
	unpack ${MY_P}.tar.gz
	if use lzw-tiff ; then
		ewarn "Applying lzw-compression toolkit..."
		unpack  libtiff-lzw-compression-kit-1.5.tar.gz || die "lzw unpack failed"
		cd libtiff-lzw-compression-kit-1.5/
		cp -f tif_lzw.c ${S}/libtiff/.
		cp README-LZW-COMPRESSION ${S}/.
	fi
	cd ${S}
	cp ${FILESDIR}/config.site config.site
	echo "DIR_HTML="${D}/usr/share/doc/${PF}/html"" >> config.site
	epatch ${FILESDIR}/${PN}-3.6.1-r1-man.so.patch || die "man.so patch failed"

	#security fixes for memory allocation problems and numerous integer overflows.
	epatch ${DISTDIR}/lib${PN}-${PV}-alt-bound.patch.bz2
	epatch ${DISTDIR}/lib${PN}-${PV}-alt-bound-fix2.patch.bz2
	epatch ${DISTDIR}/lib${PN}-${PV}-chris-bound.patch.bz2
}

src_compile() {
	OPTIMIZER="${CFLAGS}" ./configure --noninteractive || die
	emake || die
}

src_install() {
	dodir /usr/{bin,lib,share/man,share/doc/}
	dodir /usr/share/doc/${PF}/html
	ROOT="" INSTALL="/bin/sh ${S}/port/install.sh" make install || die
	preplib /usr
	dodoc README TODO VERSION README-LZW-COMPRESSION
}

pkg_postinst() {
	einfo "The LZW Compression Toolkit is now an optional component"
	einfo "of libtiff.  Add USE="lzw-tiff" to the emerge command to enable."
	ewarn "And don't forget to see README-LZW-COMPRESSION for license info."
}

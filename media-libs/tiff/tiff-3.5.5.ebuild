# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tiff/tiff-3.5.5.ebuild,v 1.4 2004/09/17 04:31:40 nerdboy Exp $

MY_P=${P/tiff-/tiff-v}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Library for manipulation of TIFF (Tag Image File Format) images."
SRC_URI="ftp://ftp.remotesensing.org/pub/libtiff/old/${MY_P}.tar.gz"
HOMEPAGE="http://www.libtiff.org/"

DEPEND=">=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3-r2"

IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha hppa amd64"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/config.site config.site
	echo "DIR_HTML="${D}/usr/share/doc/${PF}/html"" >> config.site
}

src_compile() {
	OPTIMIZER="${CFLAGS}" ./configure --noninteractive || die "configure failed"
	emake || die "emake died"
}

src_install() {
	dodir /usr/{bin,lib,share/man,share/doc}
	dodir /usr/share/doc/${PF}/html
	make ROOT="" INSTALL="/bin/sh ${S}/port/install.sh" install || die "install failed"
	preplib /usr
	dodoc COPYRIGHT README TODO VERSION
}

pkg_postinst() {
	einfo "This version was resurrected to work around a bug in fax2tiff"
	einfo "for use with Hylafax.  See bug #48077 for more info."
	einfo "It also doesn't appear to provide libtiff.so (only libtiff.a),"
	einfo "so it looks like you'll need the current stable tiff, then"
	einfo "this one with AUTOCLEAN=no.  To get back to a proper tiff,"
	einfo "unmerge both and then emerge the current stable tiff again."
	ewarn "I repeat: do not try to build hylafax or anything else against"
	ewarn "tiff-3.5.5 because it won't work.  You've been warned."
	einfo "What can I say; it's a sucky work-around..."
}

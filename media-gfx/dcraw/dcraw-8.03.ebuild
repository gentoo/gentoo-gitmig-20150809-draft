# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/dcraw/dcraw-8.03.ebuild,v 1.7 2006/08/22 02:11:01 weeve Exp $

inherit eutils flag-o-matic

DESCRIPTION="Converts the native (RAW) format of various digital cameras into netpbm portable pixmap (.ppm) image"
HOMEPAGE="http://www.cybercom.net/~dcoffin/dcraw/"
SRC_URI="http://dev.gentoo.org/~wschlich/src/media-gfx/dcraw/${P}.tar.bz2"
LICENSE="freedist GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ppc64 sparc ~x86"
DEPEND="virtual/libc
	>=media-libs/jpeg-6b
	media-libs/lcms"
RDEPEND="media-libs/netpbm"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/conversion-examples.txt doc/dcwrap
}

pkg_postinst() {
	einfo ""
	einfo "See conversion-examples.txt.gz on how to convert"
	einfo "the PPM files produced by dcraw to other image formats."
	einfo ""
	ewarn "The functionality of the external program 'fujiturn' was"
	ewarn "incoporated into dcraw and is automatically used now."
	einfo ""
	einfo "There's an example wrapper script included called 'dcwrap'."
	einfo ""
	einfo "This package also includes 'dcparse', which extracts"
	einfo "thumbnail images (preferably JPEGs) from any raw digital"
	einfo "camera formats that have them, and shows table contents."
	einfo ""
}

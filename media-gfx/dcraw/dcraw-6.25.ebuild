# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/dcraw/dcraw-6.25.ebuild,v 1.1 2005/01/17 17:25:56 wschlich Exp $

inherit eutils flag-o-matic

DESCRIPTION="Converts the native (RAW) format of various digital cameras into netpbm portable pixmap (.ppm) image"
HOMEPAGE="http://www.cybercom.net/~dcoffin/dcraw/"
SRC_URI="http://dev.gentoo.org/~wschlich/src/media-gfx/dcraw/${P}.tar.bz2"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="debug"
DEPEND="virtual/libc >=media-libs/jpeg-6b"
RDEPEND="media-libs/netpbm"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	use debug && {
		append-flags -O -ggdb -DDEBUG
		RESTRICT="${RESTRICT} nostrip"
	}
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/conversion-examples.txt doc/fujiturn-usage.txt doc/dcwrap
}

pkg_postinst() {
	einfo ""
	einfo "See conversion-examples.txt.gz on how to convert"
	einfo "the PPM files produced by dcraw to other image formats."
	einfo ""
	einfo "If you have a Fuji camera and your pictures are rotated"
	einfo "45 degrees, see fujiturn-usage.txt.gz on how to fix that."
	einfo ""
	einfo "There's an example wrapper script included called 'dcwrap'."
	einfo ""
	einfo "This package also includes 'dcparse', which extracts"
	einfo "thumbnail images (preferably JPEGs) from any raw digital"
	einfo "camera formats that have them, and shows table contents."
	einfo ""
}

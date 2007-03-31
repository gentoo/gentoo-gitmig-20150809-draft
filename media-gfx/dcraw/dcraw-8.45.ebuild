# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/dcraw/dcraw-8.45.ebuild,v 1.2 2007/03/31 15:44:07 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Converts the native (RAW) format of various digital cameras into netpbm portable pixmap (.ppm) image"
HOMEPAGE="http://www.cybercom.net/~dcoffin/dcraw/"
SRC_URI="http://dev.gentoo.org/~wschlich/src/media-gfx/dcraw/${P}.tar.bz2"
LICENSE="freedist GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gimp"

DEPEND="virtual/libc
	>=media-libs/jpeg-6b
	media-libs/lcms
	gimp? ( media-gfx/gimp )"

RDEPEND="${DEPEND}
	media-libs/netpbm"

src_compile() {
	emake CC=$(tc-getCC) || die "make failed"

	# rawphoto gimp plugin
	if use gimp; then

		# find gimptool (ugly!)
		local gimptool=/usr/bin/gimptool
		if [ ! -x ${gimptool} ]; then
			gimptool=${gimptool}-2.0
			if [ ! -x ${gimptool} ]; then
				die "Couldn't find gimptool. Please reinstall gimp."
			fi
		fi

		# build plugin
		${gimptool} --build rawphoto.c || die "gimptool failed"

	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/conversion-examples.txt doc/dcwrap

	# rawphoto gimp plugin
	if use gimp; then

		# find gimptool (ugly!)
		local gimptool=/usr/bin/gimptool
		if [ ! -x ${gimptool} ]; then
			gimptool=${gimptool}-2.0
			if [ ! -x ${gimptool} ]; then
				die "Couldn't find gimptool. Please reinstall gimp."
			fi
		fi

		# install plugin
		env DESTDIR="${D}" ${gimptool} --install-admin-bin rawphoto || die "gimptool failed"

	fi
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

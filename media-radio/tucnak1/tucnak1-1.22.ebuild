# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/tucnak1/tucnak1-1.22.ebuild,v 1.7 2008/01/16 19:27:21 armin76 Exp $

DESCRIPTION="Amateur Radio VHF Contest Logbook"
HOMEPAGE="http://tucnak.nagano.cz/tucnak1en.html"
SRC_URI="http://tucnak.nagano.cz/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="sdl"

RDEPEND="dev-util/pkgconfig
	dev-libs/glib
	sdl? ( media-libs/libpng
		media-libs/libsdl
		media-radio/tucnak1-data
		=sys-libs/slang-1*
		sys-libs/zlib )"

src_compile() {
	# use_enable will not work with their configure
	local myconf=""
	use sdl || myconf="--disable-sdl"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}

pkg_postinst() {
	elog
	elog "tucnak1 can be used with the following additional packages:"
	elog "	   media-libs/libsdl		  : Enable graphics in tucnak1"
	elog "	   media-libs/tucnak1-data	  : Also required for graphics"
	elog "	   media-radio/cwdaemon		  : Morse code daemon"
	elog "	   media-radio/ssbd			  : SSB (voice keyer) daemon"
	elog
}

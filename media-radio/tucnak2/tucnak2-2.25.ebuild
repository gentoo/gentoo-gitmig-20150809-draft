# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/tucnak2/tucnak2-2.25.ebuild,v 1.1 2009/04/17 03:32:49 darkside Exp $

inherit eutils autotools

DESCRIPTION="Amateur Radio VHF Contest Logbook"
HOMEPAGE="http://tucnak.nagano.cz"
SRC_URI="http://tucnak.nagano.cz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa ftdi gpm hamlib"

RDEPEND=">=dev-libs/glib-2
	media-libs/libsndfile
	>=media-libs/libsdl-1.2
	alsa? ( media-libs/alsa-lib )
	ftdi? ( dev-embedded/libftdi )
	gpm? ( sys-libs/gpm )
	hamlib? ( media-libs/hamlib )
	>=media-libs/libpng-1.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-2.19-doc.diff" \
		"${FILESDIR}/${PN}-2.25-appname.diff"
	eautoreconf
}

src_compile() {
	econf $(use_with alsa) $(use_with ftdi) \
		$(use_with gpm) $(use_with hamlib) --with-sdl
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	doman debian/tucnak2.1 || die "doman failed"
	dodoc AUTHORS ChangeLog TODO doc/NAVOD.sxw doc/NAVOD.pdf || die "dodoc failed"
}

pkg_postinst() {
	elog "In order to use sound with tucnak2 add yourself to the 'audio' group"
	elog "and to key your rig via the parport add yourself to the 'lp' group"
	elog ""
	elog "tucnak2 can be used with the following additional packages:"
	elog "	   media-radio/cwdaemon  : Morse output via code cwdaemon"
	elog "                             (No need to recompile)"
}

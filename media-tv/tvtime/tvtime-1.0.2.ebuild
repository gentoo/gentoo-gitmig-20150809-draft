# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/tvtime/tvtime-1.0.2.ebuild,v 1.3 2006/04/20 05:00:49 flameeyes Exp $

inherit eutils autotools

DESCRIPTION="High quality television application for use with video capture cards"
HOMEPAGE="http://tvtime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls xinerama"

RDEPEND="|| ( ( x11-libs/libSM
				x11-libs/libICE
				x11-libs/libX11
				x11-libs/libXext
				x11-libs/libXv
				x11-libs/libXxf86vm
				xinerama? ( x11-libs/libXinerama )
				x11-libs/libXtst
				x11-libs/libXau
				x11-libs/libXdmcp )
			virtual/x11 )
	>=media-libs/freetype-2
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=dev-libs/libxml2-2.5.11
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/tvtime-1.0.2-gcc41.patch

	# use 'tvtime' for the application icon see bug #66293
	sed -i -e "s/tvtime.png/tvtime/" docs/net-tvtime.desktop

	# patch to adapt to PIC or __PIC__ for pic support
	epatch "${FILESDIR}"/${PN}-pic.patch #74227

	epatch "${FILESDIR}/${P}-xinerama.patch"

	eautoreconf
}

src_compile() {
	econf $(use_enable nls) \
		$(use_with xinerama) || die "econf failed"
	emake || die "compile problem"

}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dohtml docs/html/*
	dodoc ChangeLog AUTHORS NEWS README
}

pkg_postinst() {
	einfo "A default setup for ${PN} has been saved as"
	einfo "/etc/tvtime/tvtime.xml. You may need to modify it"
	einfo "for your needs."
	einfo
	einfo "Detailed information on ${PN} setup can be"
	einfo "found at ${HOMEPAGE}help.html"
	echo
}

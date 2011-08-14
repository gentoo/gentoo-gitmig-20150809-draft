# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/tvtime/tvtime-1.0.2_p20110131-r1.ebuild,v 1.1 2011/08/14 10:42:15 a3li Exp $

EAPI=4
inherit eutils autotools

TVTIME_HGREV="111b28cca42d"

DESCRIPTION="High quality television application for use with video capture cards"
HOMEPAGE="http://tvtime.sourceforge.net/"
SRC_URI="http://www.kernellabs.com/hg/~dheitmueller/tvtime/archive/${TVTIME_HGREV}.tar.bz2 -> ${P}.tar.bz2
http://dev.gentoo.org/~a3li/distfiles/${PN}-1.0.2-alsa.patch
http://dev.gentoo.org/~a3li/distfiles/${PN}-1.0.2-alsamixer.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls xinerama"

RDEPEND="x11-libs/libSM
	x11-libs/libICE
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXv
	x11-libs/libXxf86vm
	xinerama? ( x11-libs/libXinerama )
	x11-libs/libXtst
	x11-libs/libXau
	x11-libs/libXdmcp
	>=media-libs/freetype-2
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=dev-libs/libxml2-2.5.11
	media-libs/alsa-lib
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}-${TVTIME_HGREV}"

src_prepare() {
	# Rename the desktop file, bug #308297
	mv docs/net-tvtime.desktop docs/tvtime.desktop || die
	sed -i -e "s/net-tvtime.desktop/tvtime.desktop/g" docs/Makefile.am || die

	# use 'tvtime' for the application icon see bug #66293
	sed -i -e "s/tvtime.png/tvtime/" docs/tvtime.desktop || die

	# patch to adapt to PIC or __PIC__ for pic support
	epatch "${FILESDIR}"/${PN}-pic.patch #74227

	epatch "${FILESDIR}/${PN}-1.0.2-xinerama.patch"

	# Remove linux headers and patch to build with 2.6.18 headers
	rm -f "${S}"/src/{videodev.h,videodev2.h} || die

	epatch "${FILESDIR}/${P}-libsupc++.patch"

	epatch "${FILESDIR}/${P}-autotools.patch"
	epatch "${FILESDIR}/${P}-gettext.patch"
	epatch "${FILESDIR}/${PN}-libpng-1.5.patch"

	epatch "${DISTDIR}/${PN}-1.0.2-alsa.patch"
	epatch "${DISTDIR}/${PN}-1.0.2-alsamixer.patch"

	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with xinerama) || die "econf failed"
}

src_compile() {
	# Fix underlinking, #370025
	emake LDFLAGS="${LDFLAGS} -lpthread" || die "compile problem"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dohtml docs/html/*
	dodoc ChangeLog AUTHORS NEWS README
}

pkg_postinst() {
	elog "A default setup for ${PN} has been saved as"
	elog "/etc/tvtime/tvtime.xml. You may need to modify it"
	elog "for your needs."
	elog
	elog "Detailed information on ${PN} setup can be"
	elog "found at ${HOMEPAGE}help.html"
	echo
}

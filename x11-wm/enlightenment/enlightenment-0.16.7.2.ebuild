# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.7.2.ebuild,v 1.9 2006/01/07 07:28:45 vapier Exp $

inherit eutils

DESCRIPTION="Enlightenment Window Manager"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/enlightenment-${PV/_/-}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sh sparc x86"
IUSE="doc esd nls nothemes xinerama xrandr"

RDEPEND="esd? ( >=media-sound/esound-0.2.19 )
	=media-libs/freetype-2*
	media-libs/imlib2
	|| ( (
		x11-libs/libSM
		x11-libs/libICE
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXxf86vm
		xrandr? ( x11-libs/libXrandr )
		x11-libs/libXrender
		x11-misc/xbitmaps
		x11-proto/xextproto
		x11-proto/xf86vidmodeproto
		xinerama? ( x11-libs/libXinerama x11-proto/xineramaproto )
		x11-proto/xproto
		) virtual/x11 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"
PDEPEND="!nothemes? ( x11-themes/ethemes )
	doc? ( app-doc/edox-data )"

S=${WORKDIR}/${PN}-${PV/_pre?}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-no-nls.patch
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable esd sound) \
		$(use_enable xrandr) \
		--enable-hints-ewmh \
		--enable-fsstd \
		--enable-zoom \
		|| die
	emake || die
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die
	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}"/enlightenment
	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README*
}

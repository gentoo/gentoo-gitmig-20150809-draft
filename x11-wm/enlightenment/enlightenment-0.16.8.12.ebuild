# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.8.12.ebuild,v 1.3 2008/05/04 15:32:15 maekke Exp $

inherit eutils

DESCRIPTION="Enlightenment Window Manager"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/e16-${PV/_/-}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="doc esd nls xcomposite xinerama xrandr"

RDEPEND="esd? ( >=media-sound/esound-0.2.19 )
	=media-libs/freetype-2*
	>=media-libs/imlib2-1.3.0
	!<x11-misc/e16keyedit-0.3
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXdamage
	x11-libs/libXxf86vm
	virtual/xft
	xrandr? ( x11-libs/libXrandr )
	x11-libs/libXrender
	x11-misc/xbitmaps
	xinerama? ( x11-libs/libXinerama )
	xcomposite? ( x11-libs/libXcomposite )
	nls? ( virtual/libintl )
	virtual/libiconv"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto
	xinerama? ( x11-proto/xineramaproto )
	xcomposite? ( x11-proto/compositeproto )
	x11-proto/xproto
	nls? ( sys-devel/gettext )"
PDEPEND="doc? ( app-doc/edox-data )"

S=${WORKDIR}/e16-${PV/_pre?}

pkg_setup() {
	built_with_use media-libs/imlib2 X || die "emerge imlib2 with USE=X"
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable esd sound) \
		$(use_enable xinerama) \
		$(use_enable xrandr) \
		$(use_enable xcomposite composite) \
		--enable-upgrade \
		--enable-hints-ewmh \
		--enable-fsstd \
		--enable-zoom \
		--with-imlib2 \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/e16 enlightenment
	dodoc AUTHORS ChangeLog COMPLIANCE README* docs/README* TODO
}

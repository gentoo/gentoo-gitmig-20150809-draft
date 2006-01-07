# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.9999.ebuild,v 1.15 2006/01/07 07:28:45 vapier Exp $

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/enlightenment"
ECVS_MODULE="e16/e"
inherit cvs

DESCRIPTION="Enlightenment Window Manager"
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-*"
IUSE="esd nls xinerama xrandr doc"

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
PDEPEND="doc? ( app-doc/edox-data )"

S=${WORKDIR}/e16/e

src_unpack() {
	cvs_src_unpack
	cd "${S}"
	NOCONFIGURE=blah ./autogen.sh
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable esd sound) \
		$(use_enable xinerama) \
		$(use_enable xrandr) \
		--enable-upgrade \
		--enable-hints-ewmh \
		--enable-fsstd \
		--enable-zoom \
		--with-imlib2 \
		|| die
	emake || die
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die
	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}"/enlightenment

	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README* docs/README*

	# fix default xcursor support
	cd "${D}"/usr/share/enlightenment/themes
	local deftheme=`readlink DEFAULT`
	cp -rf ${deftheme} ${deftheme}-xcursors
	rm DEFAULT
	ln -s ${deftheme}-xcursors DEFAULT
	rm -rf ${deftheme}-xcursors/cursors*
	cp "${FILESDIR}"/cursors.cfg ${deftheme}-xcursors/
}

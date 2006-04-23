# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.99.4-r5.ebuild,v 1.6 2006/04/23 22:22:40 weeve Exp $

inherit eutils autotools

PATCHLEVEL="10"
DESCRIPTION="Xine movie player"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${P}.tar.gz
	mirror://gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ppc ppc64 sparc ~x86"
IUSE="X nls lirc aalib libcaca readline curl ncurses xinerama vdr"

RDEPEND="media-libs/libpng
	>=media-libs/xine-lib-1.0
	lirc? ( app-misc/lirc )
	aalib? ( media-libs/aalib )
	libcaca? ( media-libs/libcaca )
	curl? ( >=net-misc/curl-7.10.2 )
	ncurses? ( sys-libs/ncurses )
	X? ( || ( (
			x11-libs/libX11
			x11-libs/libXrender
			x11-libs/libICE
			x11-libs/libSM
			x11-libs/libXext
			x11-libs/libXxf86vm
			x11-libs/libXv
			x11-libs/libXtst
			x11-libs/libXft
			xinerama? ( x11-libs/libXinerama )
		) virtual/x11 ) )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	X? ( || ( (
			x11-base/xorg-server
			x11-libs/libX11
			x11-libs/libXt
			x11-proto/xextproto
			x11-proto/xproto
			x11-proto/xf86vidmodeproto
			xinerama? ( x11-proto/xineramaproto )
		) virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd ${S}

	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/patches
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	rm misc/xine-bugreport
	local myconf=""

	econf \
		$(use_enable lirc) \
		$(use_enable nls) \
		$(use_enable xinerama) \
		$(use_enable vdr vdr-keys) \
		$(use_with X x) \
		$(use_with aalib) \
		$(use_with libcaca) \
		$(use_with curl) \
		$(use_with readline) \
		$(use_with ncurses) \
		${myconf} || die
	emake || die "Make failed!"
}

src_install() {
	make DESTDIR=${D} docdir=/usr/share/doc/${PF} docsdir=/usr/share/doc/${PF} install || die

	dodoc AUTHORS ChangeLog NEWS README

	for res in 16 22 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins ${S}/misc/desktops/xine_${res}x${res}.png xine.png
	done
	insinto /usr/share/pixmaps
	doins ${S}/misc/desktops/xine.xpm
}

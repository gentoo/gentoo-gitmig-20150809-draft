# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/kahakai/kahakai-0.6.1.ebuild,v 1.9 2006/05/22 02:42:53 nixphoeni Exp $

IUSE="truetype xinerama"

DESCRIPTION="A language agnostic scriptable window manager based on Waimea."
HOMEPAGE="http://kahakai.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc -alpha ~sparc"

RDEPEND="|| ( ( x11-libs/libX11
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-proto/xextproto
		xinerama? ( x11-libs/libXinerama )
		)
		virtual/x11
	)
	truetype? ( || ( x11-libs/libXft virtual/xft x11-base/xorg-x11 ) )
	=dev-lang/swig-1.3.21
	media-libs/imlib2
	dev-util/pkgconfig
	media-fonts/artwiz-fonts
	dev-libs/boost"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.57-r1
	>=sys-devel/automake-1.7.2
	sys-devel/libtool"

src_compile() {
	econf \
		`use_enable xinerama` \
		`use_enable truetype xft` || die
	emake || die
}

src_install() {
	einstall || die
	cd doc
	dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog TODO

	exeinto /etc/X11/Sessions
	echo "/usr/bin/kahakai" > ${T}/kahakai
	doexe ${T}/kahakai
}

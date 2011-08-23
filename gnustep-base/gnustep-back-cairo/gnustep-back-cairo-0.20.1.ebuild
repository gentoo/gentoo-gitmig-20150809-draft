# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-back-cairo/gnustep-back-cairo-0.20.1.ebuild,v 1.2 2011/08/23 16:00:19 voyageur Exp $

EAPI=2

inherit gnustep-base

S=${WORKDIR}/gnustep-back-${PV}

DESCRIPTION="Cairo back-end component for the GNUstep GUI Library."

HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/gnustep-back-${PV}.tar.gz"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
SLOT="0"
LICENSE="LGPL-2.1"

IUSE="opengl xim"
RDEPEND="${GNUSTEP_CORE_DEPEND}
	=gnustep-base/gnustep-gui-${PV%.*}*
	opengl? ( virtual/opengl virtual/glu )

	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXft
	x11-libs/libXrender

	>=media-libs/freetype-2.1.9
	>=x11-libs/cairo-1.2.0[X]
	!gnustep-base/gnustep-back-art
	!gnustep-base/gnustep-back-xlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	egnustep_env

	use opengl || myconf="--disable-glx"
	myconf="$myconf $(use_enable xim)"
	myconf="$myconf --enable-server=x11"
	myconf="$myconf --enable-graphics=cairo"

	econf $myconf || die "configure failed"
}

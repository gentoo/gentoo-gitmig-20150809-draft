# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-back-xlib/gnustep-back-xlib-0.9.4_pre20040920.ebuild,v 1.1 2004/09/24 01:03:33 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/back

DESCRIPTION="Default X11 back-end component for the GNUstep GUI Library."

HOMEPAGE="http://www.gnustep.org"
SRC_URI="mirro://gentoo/gnustep-back-${PV}.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="LGPL-2.1"

PROVIDE="virtual/gnustep-back"

IUSE="${IUSE} opengl xim doc"
DEPEND="${GNUSTEP_GUI_DEPEND}
	=gnustep-base/gnustep-gui-0.9.4_pre20040920
	opengl? ( virtual/opengl virtual/glu )
	virtual/xft
	=media-libs/freetype-2.1*"
RDEPEND="${DEPEND}
	${DOC_RDEPEND}"

src_compile() {
	egnustep_env

	use opengl && myconf="--enable-glx"
	myconf="$myconf `use_enable xim`"
	myconf="$myconf --enable-server=x11"
	myconf="$myconf --enable-graphics=xlib --with-name=xlib"
	econf $myconf || die "configure failed"

	egnustep_make
}


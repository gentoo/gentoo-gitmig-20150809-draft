# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-back-art/gnustep-back-art-0.9.4.ebuild,v 1.3 2004/11/02 17:32:13 blubb Exp $

inherit gnustep

S=${WORKDIR}/gnustep-back-${PV}

DESCRIPTION="libart_lgpl back-end component for the GNUstep GUI Library."

HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/gnustep-back-${PV}.tar.gz"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="LGPL-2.1"

PROVIDE="virtual/gnustep-back"

IUSE="${IUSE} opengl xim doc"
DEPEND="${GNUSTEP_GUI_DEPEND}
	opengl? ( virtual/opengl virtual/glu )
	gnustep-libs/artresources
	=gnustep-base/mknfonts-0.5
	virtual/xft
	=media-libs/freetype-2.1*
	=media-libs/libart_lgpl-2.3*"
RDEPEND="${DEPEND}
${DOC_RDEPEND}"

src_compile() {
	egnustep_env

	use opengl && myconf="--enable-glx"
	myconf="$myconf `use_enable xim`"
	myconf="$myconf --enable-server=x11"
	myconf="$myconf --enable-graphics=art --with-name=art"
	econf $myconf || die "configure failed"

	egnustep_make
}


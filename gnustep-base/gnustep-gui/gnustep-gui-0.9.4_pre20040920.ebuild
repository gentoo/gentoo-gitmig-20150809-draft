# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-gui/gnustep-gui-0.9.4_pre20040920.ebuild,v 1.1 2004/09/24 01:04:50 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/gui

DESCRIPTION="It is a library of graphical user interface classes written completely in the Objective-C language."
HOMEPAGE="http://www.gnustep.org"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="LGPL-2.1"

IUSE="${IUSE} jpeg gif png gsnd doc cups"
DEPEND="${GNUSTEP_BASE_DEPEND}
	=gnustep-base/gnustep-make-1.10.0
	=gnustep-base/gnustep-base-1.10.0
	virtual/x11
	=media-libs/tiff-3.5.7*
	jpeg? =media-libs/jpeg-6b*
	gif? =media-libs/libungif-4.1.0*
	png? =media-libs/libpng-1.2.5*
	gsnd? =media-libs/audiofile-0.2.6*
	cups? =net-print/cups-1.1.20*
	=app-text/aspell-0.50.5*"
RDEPEND="${DEPEND}
	${DOC_RDEPEND}"

src_compile() {
	egnustep_env

	myconf="--with-tiff-include=/usr/include --with-tiff-library=/usr/lib"
	myconf="$myconf `use_enable gsnd`"
	use gsnd && myconf="$myconf --with-audiofile-include=/usr/include --with-audiofile-lib=/usr/lib"
	use gif && myconf="$myconf --enable-ungif"
	myconf="$myconf `use_enable jpeg`"
	myconf="$myconf `use_enable png`"
	myconf="$myconf `use_enable cups`"
	econf $myconf || die "configure failed"

	egnustep_make || die
}


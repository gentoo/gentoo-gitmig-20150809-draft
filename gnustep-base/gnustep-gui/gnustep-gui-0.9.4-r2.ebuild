# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-gui/gnustep-gui-0.9.4-r2.ebuild,v 1.1 2005/03/19 23:19:34 fafhrd Exp $

inherit gnustep

DESCRIPTION="It is a library of graphical user interface classes written completely in the Objective-C language."
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"

KEYWORDS="~ppc ~x86 ~amd64 ~sparc ~alpha"
SLOT="0"
LICENSE="LGPL-2.1"

IUSE="${IUSE} jpeg gif png gsnd doc cups"
DEPEND="${GNUSTEP_BASE_DEPEND}
	~gnustep-base/gnustep-base-1.10.1
	virtual/x11
	>=media-libs/tiff-3*
	jpeg? ( >=media-libs/jpeg-6b* )
	gif? ( >=media-libs/giflib-4.1* )
	png? ( >=media-libs/libpng-1.2* )
	gsnd? ( >=media-libs/audiofile-0.2* )
	cups? ( >=net-print/cups-1.1* )
	app-text/aspell"
RDEPEND="${DEPEND}
	${DOC_RDEPEND}"

egnustep_install_domain "System"

src_unpack() {
	unpack ${A}
	cd ${S}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/gui-def.patch
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/gui-gsspell.patch
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/gui-use-giflib.patch.bz2
}

src_compile() {
	egnustep_env

	myconf="--with-tiff-include=/usr/include --with-tiff-library=/usr/lib"
	myconf="$myconf `use_enable gsnd`"
	use gsnd && myconf="$myconf --with-audiofile-include=/usr/include --with-audiofile-lib=/usr/lib"
	use gif && myconf="$myconf --disable-ungif --enable-giflib"
	myconf="$myconf `use_enable jpeg`"
	myconf="$myconf `use_enable png`"
	myconf="$myconf `use_enable cups`"
	econf $myconf || die "configure failed"

	egnustep_make || die
}


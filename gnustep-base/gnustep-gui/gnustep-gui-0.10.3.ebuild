# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-gui/gnustep-gui-0.10.3.ebuild,v 1.4 2006/08/30 07:56:01 blubb Exp $

inherit gnustep

DESCRIPTION="Library of GUI classes written in Obj-C"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"

# no ppc-macos as it bails out while compiling, needs work
KEYWORDS="~alpha amd64 ~ppc sparc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"

# doc has sandbox violations
IUSE="cups gif gsnd jpeg png"
DEPEND="${GNUSTEP_CORE_DEPEND}
	>=gnustep-base/gnustep-make-1.10
	>=gnustep-base/gnustep-base-1.10
	|| (
		( x11-libs/libXt )
		virtual/x11
	)
	>=media-libs/tiff-3
	jpeg? ( >=media-libs/jpeg-6b )
	gif? ( >=media-libs/giflib-4.1 )
	png? ( >=media-libs/libpng-1.2 )
	gsnd? (
		>=media-libs/audiofile-0.2
	)
	cups? ( >=net-print/cups-1.1 )
	app-text/aspell"
# gsnd needs a recent portaudio that's not in the tree yet
#		=media-libs/portaudio-19*
RDEPEND="${DEPEND}
	${DEBUG_DEPEND}
	${DOC_RDEPEND}"

egnustep_install_domain "System"

src_unpack() {
	unpack ${A}

	cd ${S}

#	if use gsnd ;
#	then
#	    sed -i -e "s:#include <portaudio.h>:#include <portaudio-19/portaudio.h>:g" ${S}/Tools/gsnd/gsnd.m
#	    sed -i -e "s:-lportaudio:-lportaudio-19:g" ${S}/Tools/gsnd/GNUmakefile
#	    sed -i -e "s:^BUILD_GSND=.*$:BUILD_GSND=gsnd:g" ${S}/config.make.in
#	fi
}

src_compile() {
	egnustep_env

	myconf="--with-tiff-include=/usr/include --with-tiff-library=/usr/lib"
	use gif && myconf="$myconf --disable-ungif --enable-libgif"
	myconf="$myconf `use_enable jpeg`"
	myconf="$myconf `use_enable png`"
	myconf="$myconf `use_enable cups`"

	if use gsnd ;
	then
	    myconf="$myconf --enable-gsnd"
	    myconf="$myconf --with-audiofile-include=/usr/include --with-audiofile-lib=/usr/lib"
#	    myconf="$myconf --with-include-flags=-I/usr/include/portaudio-19"
	fi

	econf $myconf || die "configure failed"

	egnustep_make || die

#	if use doc ;
#	then
#	    cd ${S}/Documentation
#	    egnustep_make || die
#	fi
}

src_install() {
	egnustep_env
	egnustep_install || die

#	if use doc ;
#	then
#		cd ${S}/Documentation
#		egnustep_install || die
#	fi

	use gsnd && newinitd ${FILESDIR}/gsnd.initd gsnd
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnustep-back/gnustep-back-0.8.5.ebuild,v 1.6 2004/04/03 23:06:03 spyderous Exp $

DESCRIPTION="GNUstep GUI backend"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 -ppc -sparc"
DEPEND="=dev-util/gnustep-gui-${PV}*
	>=media-libs/tiff-3.5.7
	>=media-libs/jpeg-6b-r2
	virtual/x11
	>=x11-wm/windowmaker-0.80.1"
S=${WORKDIR}/${P}

src_compile() {

	local myconf

	# For a different graphics library... choose one
	#
	# myconf="--enable-graphics=xdps --with-name=xdps"
	#
	# -OR-
	#
	# make sure you have libart_lgpl installed and...
	#
	# myconf="--enable-graphics=art --with-name=art"


	. /usr/GNUstep/System/Makefiles/GNUstep.sh

	./configure \
		--prefix=/usr/GNUstep \
		--with-jpeg-library=/usr/lib \
		--with-jpeg-include=/usr/include \
		--with-tiff-library=/usr/lib \
		--with-tiff-include=/usr/include \
		--with-x ${myconf} || die "configure failed"

	# if we don't have Xft1, then we don't do Xft support at all
	if [ ! -f "/usr/X11R6/include/X11/Xft1/Xft.h" ]; then
		sed "s,^#define HAVE_XFT.*,#undef HAVE_XFT,g" config.h > config.h.new
		sed "s,^#define HAVE_UTF8.*,#undef HAVE_UTF8,g" config.h.new > config.h
		sed "s,^WITH_XFT=.*,WITH_XFT=no," config.make > config.make.new
		sed "s,-lXft,," config.make.new > config.make
	fi

	mkdir -p $TMP/fakehome/GNUstep
	make HOME=$TMP/fakehome GNUSTEP_USER_ROOT=$TMP/fakehome/GNUstep || die
}

src_install () {
	. /usr/GNUstep/System/Makefiles/GNUstep.sh
	make \
		GNUSTEP_INSTALLATION_DIR=${D}/usr/GNUstep/System \
		INSTALL_ROOT_DIR=${D} \
		install || die "install failed"
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/tilp/tilp-6.68.ebuild,v 1.1 2003/11/04 11:30:44 phosphan Exp $

DESCRIPTION="TiLP is a linking program for Texas Instruments' graphing calculators."
HOMEPAGE="http://tilp.sourceforge.net/"

SRC_URI="mirror://sourceforge/tilp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND="dev-libs/libticables
		dev-libs/libticalcs
		dev-libs/libtifiles
		app-text/dos2unix
		=x11-libs/gtk+-2.2*"

src_compile() {
	# Note the special option --with-fontpath-prefix below.
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-fontpath-prefix=${D}/usr/X11R6/lib/X11/fonts \
		--enable-exit-homedir || die "./configure failed"

	emake || die
}

src_install() {
	# the SHARE_DIR is required cause it isn't set properly in a makefile
	einstall SHARE_DIR=${D}/usr/share/tilp || die
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README* RELEASE THANKS TODO
}

pkg_postinst() {
	# TiLP installs a font into /usr/X11R6/lib/X11/fonts/misc, so I'm running
	# mkfontdir here to update the system
	mkfontdir -- /usr/X11R6/lib/X11/fonts/misc
}

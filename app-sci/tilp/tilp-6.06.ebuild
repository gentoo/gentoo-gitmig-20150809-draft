# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/tilp/tilp-6.06.ebuild,v 1.2 2003/09/08 07:25:15 msterret Exp $

DESCRIPTION="TiLP is a linking program for Texas Instruments' graphing calculators."
HOMEPAGE="http://tilp.sourceforge.net/"

# Should figure out a way to allow downloads from different server, rather than
# forcing it to come from Time-Warner
SRC_URI="http://twtelecom.dl.sourceforge.net/sourceforge/tilp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

# Only tested on x86 so far...
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-libs/libticables
        dev-libs/libticalcs
		dev-libs/libtifiles
		=x11-libs/gtk+-1.2*"

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
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README* RELEASE THANKS TODO
}

pkg_postinst() {
	# TiLP installs a font into /usr/X11R6/lib/X11/fonts/misc, so I'm running
	# mkfontdir here to update the system
	mkfontdir -- /usr/X11R6/lib/X11/fonts/misc
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/tilp/tilp-6.68-r1.ebuild,v 1.2 2004/03/30 10:10:13 phosphan Exp $

inherit eutils

DESCRIPTION="TiLP is a linking program for Texas Instruments' graphing calculators."
HOMEPAGE="http://tilp.sourceforge.net/"

SRC_URI="mirror://sourceforge/tilp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-libs/libticables-3.7.7
		>=dev-libs/libticalcs-4.4.4
		>=dev-libs/libtifiles-0.5.5
		app-text/dos2unix
		>=x11-libs/gtk+-2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-keepdir.patch
}

src_compile() {
	# Note the special option --with-fontpath-prefix below.
	sed -e 's/GTK_DISABLE_DEPRECATED/GTK_DEPRECATED/g' -i src/Makefile.in
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		--with-fontpath-prefix=${D}/usr/X11R6/lib/X11/fonts \
		--enable-exit-homedir || die "./configure failed"

	emake || die
}

src_install() {
	# the SHARE_DIR is required cause it isn't set properly in a makefile
	einstall SHARE_DIR=${D}/usr/share/tilp || die
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README* RELEASE THANKS TODO
	keepdir /usr/lib/tilp
}

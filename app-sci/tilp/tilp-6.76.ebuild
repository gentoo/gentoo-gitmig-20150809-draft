# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/tilp/tilp-6.76.ebuild,v 1.1 2004/12/02 08:47:19 phosphan Exp $

inherit eutils

DESCRIPTION="TiLP - A linking program for Texas Instruments' graphing calculators"
HOMEPAGE="http://tilp.info/"
SRC_URI="mirror://sourceforge/tilp/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="nls"

DEPEND=">=dev-libs/libticables-3.8.6
		>=dev-libs/libticalcs-4.5.5
		>=dev-libs/libtifiles-0.6.1
		app-text/dos2unix
		>=x11-libs/gtk+-2
		>=gnome-base/libglade-2
		nls? sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-makefile.patch
	epatch ${FILESDIR}/${PV}-makefile-desktop.patch
	epatch ${FILESDIR}/keepdir.patch
}

src_compile() {
	# Note the special option --with-fontpath-prefix below.
	cd ${WORKDIR}/${P}/
	./configure \
		$(use_enable nls) \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		--with-fontpath-prefix=${D}/usr/X11R6/lib/X11/fonts \
		--enable-exit-homedir || die

	emake || die
}

src_install() {
	# The SHARE_DIR is required since it isn't set properly in a makefile.
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README README.linux RELEASE THANKS TODO
	keepdir /usr/lib/tilp
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xcdroast/xcdroast-0.98_alpha15.ebuild,v 1.3 2003/11/21 23:38:35 spider Exp $

inherit eutils

S=${WORKDIR}/${P/_/}
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
HOMEPAGE="http://www.xcdroast.org/"
SRC_URI="mirror://sourceforge/xcdroast/${P/_/}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="nls dvdr gtk2"

DEPEND="gtk2? ( >=x11-libs/gtk+-2.0.3 )
	!gtk2? ( =x11-libs/gtk+-1.2.10* )
	=dev-libs/glib-1.2*
	>=media-libs/gdk-pixbuf-0.16.0
	>=media-libs/giflib-3.0
	dev-libs/libpcre
	>=app-cdr/cdrtools-2.01_alpha17"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${P/_/}.tar.gz
	cd ${S}/src

	#Patch to enable DVD-writing
	use dvdr && epatch ${FILESDIR}/${P/_/}-dvd.patch
}

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use gtk2 && myconf="${myconf} --enable-gtk2"

	econf ${myconf} || die
	make PREFIX=/usr || die
}

src_install() {
	make PREFIX=/usr DESTDIR=${D} install || die

	cd doc
	dodoc DOCUMENTATION FAQ README* TRANSLATION.HOWTO
	cd ..

	# move man pages to /usr/share/man to be LFH compliant
	mv ${D}/usr/man ${D}/usr/share

	#remove extraneous directory
	rm ${D}/usr/etc -rf
}

pkg_postinst() {
	if use dvdr; then
		echo
		einfo "You are now using X-CD-Roast with the cdrtools patches for several"
		einfo "DVD writers.  You can also use cdrecord-ProDVD, which has to be"
		einfo "installed manually."
		einfo "See http://www.xcdroast.org/xcdr098/README.ProDVD.txt for further"
		einfo "instructions."
		echo
	fi
}

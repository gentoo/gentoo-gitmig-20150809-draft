# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xcdroast/xcdroast-0.98_alpha15-r1.ebuild,v 1.3 2003/11/21 23:38:35 spider Exp $

inherit eutils

S=${WORKDIR}/${P/_/}
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
HOMEPAGE="http://www.xcdroast.org/"
SRC_URI="mirror://sourceforge/xcdroast/${P/_/}.tar.gz
	dvdr? ( ftp://ftp.berlios.de/pub/cdrecord/ProDVD/cdrecord-prodvd-2.01a12-i586-pc-linux-gnu )
	dvdr? ( ftp://ftp.berlios.de/pub/cdrecord/ProDVD/cdrecord-prodvd-2.0-powerpc-unknown-linux-gnu )"
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

	#install cdrecord.prodvd
	if use dvdr; then
		into /usr/lib/xcdroast-0.98
		use x86 && newbin ${DISTDIR}/cdrecord-prodvd-2.01a12-i586-pc-linux-gnu cdrecord.prodvd
		use ppc && newbin ${DISTDIR}/cdrecord-prodvd-2.0-powerpc-unknown-linux-gnu cdrecord.prodvd
	fi
}

pkg_postinst() {
	if use dvdr; then
		echo
		einfo "cdrecord-ProDVD has been installed with this package.  It will be used only"
		einfo "for images larger than 1GB."
		einfo "You have to type in the license key that is available free for personal use."
		einfo "See ftp://ftp.berlios.de/pub/cdrecord/ProDVD/README for furhter information."
		echo
	fi
}

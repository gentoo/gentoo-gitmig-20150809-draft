# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xcdroast/xcdroast-0.98_alpha15-r3.ebuild,v 1.12 2005/03/30 01:05:15 pylon Exp $

inherit eutils

S=${WORKDIR}/${P/_/}
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
HOMEPAGE="http://www.xcdroast.org/"
SRC_URI="mirror://sourceforge/xcdroast/${P/_/}.tar.gz
	mirror://gentoo/${P}_new_configure.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc amd64"
IUSE="nls dvdr gtk2"

DEPEND="gtk2? ( >=x11-libs/gtk+-2.0.3 )
	!gtk2? ( >=media-libs/gdk-pixbuf-0.16.0 )"

RDEPEND="
	dvdr? (
		x86? ( app-cdr/cdrecord-prodvd )
	)
	virtual/cdrtools"

src_unpack() {
	unpack ${P/_/}.tar.gz
	cd ${S}
	unpack ${P}_new_configure.tar.gz

	cd ${S}/src
	use gtk2 && epatch ${FILESDIR}/gtk2locale.patch
	use amd64 && epatch ${FILESDIR}/64bit_gsize.patch
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable gtk2) \
		--disable-dependency-tracking || die
	
	make PREFIX=/usr || die
}

src_install() {
	make PREFIX=/usr DESTDIR=${D} install || die

	cd ${S}/doc
	dodoc DOCUMENTATION FAQ README* TRANSLATION.HOWTO

	# move man pages to /usr/share/man to be LFH compliant
	mv ${D}/usr/man ${D}/usr/share

	#remove extraneous directory
	rm ${D}/usr/etc -rf

	#install cdrecord.prodvd
	if use dvdr; then
		dosym /usr/bin/cdrecord-ProDVD /usr/lib/xcdroast-0.98/bin/cdrecord.prodvd
	fi

	insinto /usr/share/icons/hicolor/48x48/apps
	newins ${S}/xpms/xcdricon.xpm xcdroast.xpm
	
	make_desktop_entry xcdroast "X-CD-Roast" xcdroast "AudioVideo;DiscBurning"
}

pkg_postinst() {
	if use dvdr; then
		echo
		einfo "cdrecord-ProDVD has been installed with this package.  It will be used only"
		einfo "for images larger than 1GB."
		einfo "You have to type in the license key that is available free for personal use."
		einfo "See ftp://ftp.berlios.de/pub/cdrecord/ProDVD/README for further information."
		echo
	fi
}

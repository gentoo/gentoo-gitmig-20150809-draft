# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xcdroast/xcdroast-0.98_alpha14-r2.ebuild,v 1.1 2003/09/04 00:17:33 pylon Exp $

inherit eutils

S=${WORKDIR}/${P/_/}
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
HOMEPAGE="http://www.xcdroast.org/"
SRC_URI="mirror://sourceforge/xcdroast/${P/_/}.tar.gz
	http://www.xcdroast.org/xcdr098/patches/error_write_tracks.patch
	http://www.xcdroast.org/xcdr098/patches/cdrtools201a17.patch
	http://www.xcdroast.org/xcdr098/patches/dvd_atip.patch
	http://www.xcdroast.org/xcdr098/patches/debian_scan.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="nls dvd"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	>=media-libs/gdk-pixbuf-0.16.0
	>=media-libs/giflib-3.0
	>=app-cdr/cdrtools-2.01_alpha17
	dvd? ( >=app-cdr/cdrtools-dvdr-2.0 )"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${P/_/}.tar.gz
	cd ${S}/src

	# Patch to fix "Error Writing Tracks" Bug
	epatch ${DISTDIR}/error_write_tracks.patch

	# This will also fix the startup segfaults on Gentoo systems
	epatch ${DISTDIR}/debian_scan.patch

	# Patch to fix startup problem with cdrools >=2.01alpha17
	epatch ${DISTDIR}/cdrtools201a17.patch

	# Patches for DVD writing
	if use dvd; then
		# Patch to fix fixes the display of ATIP information of DVD-media.
		epatch ${DISTDIR}/dvd_atip.patch

		#Patch to enable DVD-Writing
		epatch ${FILESDIR}/${P/_/}-dvd.patch
	fi
}

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"

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

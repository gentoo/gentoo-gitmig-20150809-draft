# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib/imlib-1.9.15-r2.ebuild,v 1.13 2010/11/08 23:15:09 maekke Exp $

inherit autotools eutils

PVP=(${PV//[-\._]/ })
DESCRIPTION="Image loading and rendering library"
HOMEPAGE="http://ftp.acc.umu.se/pub/GNOME/sources/imlib/1.9/"
SRC_URI="mirror://gnome/sources/${PN}/${PVP[0]}.${PVP[1]}/${P}.tar.bz2
	mirror://gentoo/gtk-1-for-imlib.m4.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc deprecated"

RDEPEND="deprecated? ( =x11-libs/gtk+-1.2* )
	>=media-libs/tiff-3.5.5
	>=media-libs/giflib-4.1.0
	>=media-libs/libpng-1.2.1
	virtual/jpeg
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXext"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix aclocal underquoted definition warnings.
	# Conditionalize gdk functions for bug 40453.
	# Fix imlib-config for bug 3425.
	epatch "${FILESDIR}"/${P}.patch
	epatch "${FILESDIR}"/${PN}-security.patch #security #72681
	epatch "${FILESDIR}"/${P}-bpp16-CVE-2007-3568.patch # security #201887
	epatch "${FILESDIR}"/${P}-fix-rendering.patch #197489
	epatch "${FILESDIR}"/${P}-asneeded.patch #207638

	mkdir m4 && cp "${WORKDIR}"/gtk-1-for-imlib.m4 m4

	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf --sysconfdir=/etc/imlib \
		$(use_enable deprecated gdk) \
		$(use_enable deprecated gtktest)

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README
	use doc && dohtml doc/*

	# Hack to avoid installing pkgconfig file.
	use deprecated || rm "${D}"/usr/lib*/pkgconfig/imlibgdk.pc
}

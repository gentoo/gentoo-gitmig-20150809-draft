# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib/imlib-1.9.14-r3.ebuild,v 1.2 2004/12/04 23:22:20 kingtaco Exp $

inherit gnome.org libtool eutils

DESCRIPTION="general image loading and rendering library"
HOMEPAGE="http://developer.gnome.org/arch/imaging/imlib.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/tiff-3.5.5
	>=media-libs/giflib-4.1.0
	>=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b"

src_unpack() {
	unpack ${A}
	# fix config script   bug 3425
	cd ${S}
	mv imlib-config.in imlib-config.in.bad
	sed -e "49,51D" -e "55,57D" imlib-config.in.bad > imlib-config.in

	# Security fix per bug #62487
	epatch ${FILESDIR}/${P}-bound.patch

	#Security fix for bug #72681
	epatch ${FILESDIR}/${P}-sec2.patch
}

src_compile() {
	elibtoolize
	econf --sysconfdir=/etc/imlib || die
	emake || die
}

src_install() {
	einstall \
		includedir=${D}/usr/include \
		sysconfdir=${D}/etc/imlib \
		|| die
	preplib /usr

	dodoc AUTHORS ChangeLog README NEWS
	dohtml -r doc
}

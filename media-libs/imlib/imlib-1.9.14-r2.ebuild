# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib/imlib-1.9.14-r2.ebuild,v 1.6 2004/10/17 06:07:42 hardave Exp $

inherit gnome.org libtool eutils

DESCRIPTION="general image loading and rendering library"
HOMEPAGE="http://developer.gnome.org/arch/imaging/imlib.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips ppc64"
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

	dodoc AUTHORS COPYING* ChangeLog README NEWS
	dohtml -r doc
}

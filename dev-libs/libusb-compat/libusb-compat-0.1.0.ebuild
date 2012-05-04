# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb-compat/libusb-compat-0.1.0.ebuild,v 1.4 2012/05/04 18:35:50 jdhore Exp $

EAPI="2"

DESCRIPTION="Userspace access to USB devices (libusb-0.1 compat wrapper)"
HOMEPAGE="http://libusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/libusb/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

RDEPEND="dev-libs/libusb:1
		!dev-libs/libusb:0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		$(use_enable debug debug-log)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"

	insinto /usr/share/doc/${PF}/examples
	doins examples/*.c
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-1.0.9_rc3.ebuild,v 1.4 2012/02/01 22:37:50 ranger Exp $

EAPI=4
inherit autotools

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.org/"
SRC_URI="mirror://debian/pool/main/libu/${PN}-${PV%.*}/${PN}-${PV%.*}_${PV/_/~}.orig.tar.gz"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 -x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="debug doc static-libs"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

DOCS="AUTHORS NEWS PORTING README THANKS TODO"

S=${WORKDIR}/${P/_/-}

src_prepare() {
	# aclocal: couldn't open directory `m4': No such file or directory
	mkdir m4

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable debug debug-log)
}

src_compile() {
	default

	use doc && emake -C doc docs
}

src_install() {
	default

	if use doc; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c

		dohtml doc/html/*
	fi

	rm -f "${ED}"usr/lib*/libusb*.la
}

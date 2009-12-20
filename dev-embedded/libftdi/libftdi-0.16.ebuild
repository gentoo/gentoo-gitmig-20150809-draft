# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/libftdi/libftdi-0.16.ebuild,v 1.6 2009/12/20 12:39:35 vapier Exp $

EAPI=1

DESCRIPTION="Userspace access to FTDI USB interface chips"
HOMEPAGE="http://www.intra2net.com/en/developer/libftdi/"
SRC_URI="http://www.intra2net.com/en/developer/libftdi/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="doc examples"

RDEPEND="virtual/libusb:0"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# don't bother building examples as we dont want the binaries
	# installed and the Makefile has broken install targets
	sed -i '/^SUBDIRS =/s:examples::' Makefile.in

	use doc || export ac_cv_path_DOXYGEN=true
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc ChangeLog README

	if use doc ; then
		doman doc/man/man3/*
		dohtml doc/html/*
	fi
	if use examples ; then
		docinto examples
		dodoc examples/*.c
	fi
}

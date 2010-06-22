# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/libftdi/libftdi-9999.ebuild,v 1.1 2010/06/22 23:10:20 vapier Exp $

EAPI="2"

if [[ ${PV} == 9999* ]] ; then
	EGIT_REPO_URI="git://developer.intra2net.com/libftdi"
	inherit git autotools
else
	SRC_URI="http://www.intra2net.com/en/developer/libftdi/download/${P}.tar.gz"
	KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
fi

DESCRIPTION="Userspace access to FTDI USB interface chips"
HOMEPAGE="http://www.intra2net.com/en/developer/libftdi/"

LICENSE="LGPL-2"
SLOT="0"
IUSE="cxx doc examples python"

RDEPEND="virtual/libusb:0
	cxx? ( dev-libs/boost )
	python? ( dev-lang/python )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	if [[ ${PV} == 9999* ]] ; then
		eautoreconf
	fi

	# don't bother building examples as we dont want the binaries
	# installed and the Makefile has broken install targets
	sed -i '/^SUBDIRS =/s:examples::' Makefile.in
}

src_configure() {
	use doc || export ac_cv_path_DOXYGEN=true
	econf \
		$(use_enable cxx libftdipp) \
		$(use_enable python python-binding)
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

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/hamlib/hamlib-1.2.9.ebuild,v 1.1 2009/05/20 01:51:41 darkside Exp $

inherit autotools eutils multilib

DESCRIPTION="Ham radio backend rig control libraries"
HOMEPAGE="http://hamlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc python tcl"

RESTRICT="test"

RDEPEND="virtual/libc
	=virtual/libusb-0*
	python? ( dev-lang/python
		dev-lang/tcl )
	tcl? ( dev-lang/tcl )"

DEPEND=" ${RDEPEND}
	dev-util/pkgconfig
	dev-lang/swig
	dev-libs/libxml2
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-pkgconfig-fix.diff \
		"${FILESDIR}"/${PN}-ltdl.diff

	# remove bundled libltdl copy
	rm -rf libltdl

	eautoreconf
}

src_compile() {
	econf \
		--libdir=/usr/$(get_libdir)/hamlib \
		--disable-static \
		--with-rpc-backends \
		--without-perl-binding \
		$(use_with python python-binding) \
		$(use_with tcl    tcl-binding)

	emake || die "emake failed"

	if use doc ; then
		cd doc && make doc || die "make doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS PLAN README README.betatester \
		README.developer LICENSE NEWS TODO

	if use doc; then
		dohtml doc/html/*
	fi

	insinto /usr/$(get_libdir)/pkgconfig
	doins hamlib.pc

	echo "LDPATH=/usr/$(get_libdir)/hamlib" > "${T}"/73hamlib
	doenvd "${T}"/73hamlib
}

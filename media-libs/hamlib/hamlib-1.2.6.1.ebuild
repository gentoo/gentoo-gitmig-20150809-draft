# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/hamlib/hamlib-1.2.6.1.ebuild,v 1.1 2007/06/16 23:01:39 anant Exp $

inherit eutils multilib

DESCRIPTION="Ham radio backend rig control libraries"
HOMEPAGE="http://hamlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="doc gd python tk X"

RESTRICT="test"

RDEPEND="virtual/libc
	gd? ( media-libs/gd )
	python? ( dev-lang/python
		dev-lang/tcl )
	tk? ( dev-lang/tk )"
DEPEND=">=sys-devel/libtool-1.5
	>=sys-devel/autoconf-2.54
	>=sys-devel/automake-1.7
	>=dev-util/pkgconfig-0.15
	>=dev-lang/swig-1.3.14
	dev-libs/libxml2
	doc? ( >=app-doc/doxygen-1.3.5 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-pkgconfig-fix.diff || \
		die "epatch failed"
}

src_compile() {
	econf \
		--libdir=/usr/$(get_libdir)/hamlib \
		--disable-static \
		--with-microtune \
		--without-rpc-backends \
		--without-perl-binding \
		$(use_with python python-binding) \
		$(use_with tk tcl-binding) \
		$(use_with gd rigmatrix) \
		$(use_with X x) \
		|| die "configure failed"

	emake || die "emake failed"

	if use doc ; then
		cd doc && make doc || die "make doc failed"
	fi
}

src_install() {
	einstall \
		libdir="${D}"/usr/$(get_libdir)/hamlib || \
		die "einstall failed"

	dodoc AUTHORS PLAN README README.betatester \
		README.developer LICENSE NEWS TODO

	if use doc; then
		dohtml doc/html/*
		doman doc/man/man3/*
	fi

	insinto /usr/$(get_libdir)/pkgconfig
	doins hamlib.pc

	echo "LDPATH=/usr/$(get_libdir)/hamlib" > "${T}"/73hamlib
	doenvd "${T}"/73hamlib
}

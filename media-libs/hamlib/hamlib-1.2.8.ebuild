# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/hamlib/hamlib-1.2.8.ebuild,v 1.1 2008/12/04 17:58:18 darkside Exp $

inherit eutils multilib libtool

DESCRIPTION="Ham radio backend rig control libraries"
HOMEPAGE="http://hamlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc python tcl"

RESTRICT="test"

RDEPEND="virtual/libc
	python? ( dev-lang/python
		dev-lang/tcl )
	tcl? ( dev-lang/tcl )"

DEPEND=" ${RDEPEND}
	>=sys-devel/libtool-1.5
	>=dev-util/pkgconfig-0.15
	>=dev-lang/swig-1.3.14
	dev-libs/libxml2
	doc? ( >=app-doc/doxygen-1.3.5 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-pkgconfig-fix.diff

	# Needed for FreeBSD - Please do not remove
	elibtoolize
}

src_compile() {
	econf \
		--libdir=/usr/$(get_libdir)/hamlib \
		--disable-static \
		--with-microtune \
		--with-rpc-backends \
		--without-perl-binding \
		$(use_with python python-binding) \
		$(use_with tcl    tcl-binding)

	emake -j1 || die "emake failed"

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

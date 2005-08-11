# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/hamlib/hamlib-1.2.4.ebuild,v 1.2 2005/08/11 01:08:16 killsoft Exp $

inherit eutils multilib

DESCRIPTION="Ham radio backend rig control libraries"
HOMEPAGE="http://hamlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~amd64"
IUSE="doc gd python tcltk X"

RDEPEND="virtual/libc
	X? ( virtual/x11 )
	gd? ( media-libs/gd )
	python? ( dev-lang/python )
	tcltk? ( dev-lang/tk )"
DEPEND=">=sys-devel/libtool-1.5
	>=sys-devel/autoconf-2.54
	>=sys-devel/automake-1.7
	>=dev-util/pkgconfig-0.15
	>=dev-lang/swig-1.3.14
	dev-libs/libxml2
	doc? ( >=app-doc/doxygen-1.3.5 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-pkgconfig-fix.diff || \
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
		$(use_with tcltk tcl-binding) \
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
		libdir=${D}/usr/$(get_libdir)/hamlib || \
		die "einstall failed"
	dodoc AUTHORS PLAN README README.betatester
	dodoc README.developer LICENSE NEWS TODO
	if use doc; then
		dohtml doc/html/*
		doman doc/man/man3/*
	fi
	insinto /usr/$(get_libdir)/pkgconfig
	doins hamlib.pc
	echo "LDPATH=/usr/$(get_libdir)/hamlib" > 73hamlib
	insinto /etc/env.d
	doins 73hamlib
}

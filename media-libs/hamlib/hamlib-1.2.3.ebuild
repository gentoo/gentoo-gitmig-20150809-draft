# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/hamlib/hamlib-1.2.3.ebuild,v 1.1 2004/12/08 23:41:12 killsoft Exp $

inherit eutils

DESCRIPTION="Ham radio backend rig control libraries"
HOMEPAGE="http://sourceforge.net/projects/hamlib/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE="doc gd python tcltk X"

RDEPEND="virtual/libc
	X? ( virtual/x11 )
	gd? ( media-libs/gd )
	python? ( dev-lang/python )
	tcltk? ( dev-lang/tk )
	dev-lang/swig"
DEPEND=">=sys-devel/libtool-1.5
	>=sys-devel/autoconf-2.5
	>=sys-devel/automake-1.7
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=app-doc/doxygen-1.3.5 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-pkgconfig-fix.diff || \
		die "epatch failed"
}

src_compile() {
	econf \
		--libdir=/usr/lib/hamlib \
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
		libdir=${D}/usr/lib/hamlib || \
		die "einstall failed"
	dodoc AUTHORS PLAN README README.betatester
	dodoc README.developer LICENSE NEWS TODO
	if use doc; then
		dohtml doc/html/*
		doman doc/man/man3/*
	fi
	insinto /usr/lib/pkgconfig
	doins hamlib.pc
	echo "LDPATH=/usr/lib/hamlib" > 73hamlib
	insinto /etc/env.d
	doins 73hamlib
}

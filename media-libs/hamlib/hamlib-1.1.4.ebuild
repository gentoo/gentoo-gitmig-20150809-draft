# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/hamlib/hamlib-1.1.4.ebuild,v 1.1 2004/06/04 04:36:24 rphillips Exp $

inherit eutils

DESCRIPTION="Ham radio backend rig control libraries"
HOMEPAGE="http://sourceforge.net/projects/hamlib/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~alpha"
IUSE="doc gd X"

RDEPEND="virtual/glibc
	X? ( virtual/x11 )
	gd? ( media-libs/libgd )"

DEPEND="${RDEPEND}
	sys-devel/libtool
	doc? ( >=app-doc/doxygen-1.3.5-r1 )
	>=dev-util/pkgconfig-0.12.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-pkgconfig-fix.diff || \
		die "epatch failed"
}

src_compile() {
	econf \
		--libdir=/usr/lib/hamlib \
		--includedir=/usr/include/hamlib \
		--with-microtune \
		--without-rpc-backends \
		--without-perl-binding \
		--without-tcl-binding \
		$(use_with gd rigmatrix) \
		$(use_with X x) \
		|| die "configure failed"
	emake || die "emake failed"
	if [ -n "$(use doc)" ] ; then
		cd doc && make doc || die "make doc failed"
	fi
}

src_install() {
	einstall \
		libdir=${D}/usr/lib/hamlib \
		includedir=${D}/usr/include/hamlib || \
		die "einstall failed"
	dodoc AUTHORS PLAN README README.betatester
	dodoc README.developer LICENSE NEWS TODO
	if [ -n "$(use doc)" ]; then
		dohtml doc/html/*
		doman doc/man/man3/*
	fi
	insinto /usr/lib/pkgconfig
	doins hamlib.pc
}

pkg_postinst() {
	if [ ! -n "$(use gd)" ] ; then
		echo
		ewarn "Your USE flags do not contain \"gd\"."
		ewarn "Therefore, hamlib has been built without"
		ewarn "rigmatrix support. If this is not what you"
		ewarn "want, add \"gd\" to your /etc/make.conf USE"
		ewarn "flags and re-emerge hamlib."
		echo
	fi
	echo
	einfo "hamlib is now installed. Add \"hamlib\" to"
	einfo "your /etc/make.conf USE flags to enable ham"
	einfo "radio applications to use hamlib libraries."
	echo
}

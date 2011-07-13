# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkimg/tkimg-1.5_pre324-r1.ebuild,v 1.1 2011/07/13 07:25:11 jlec Exp $

EAPI=3

VIRTUALX_USE=test

inherit eutils virtualx autotools flag-o-matic prefix

MYP="${PN}${PV}"

DESCRIPTION="Adds a lot of image formats to Tcl/Tk"
HOMEPAGE="http://tkimg.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

IUSE="doc test"
SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"

RDEPEND="
	dev-lang/tk
	>=dev-tcltk/tcllib-1.11
	>=media-libs/libpng-1.4.7
	virtual/jpeg
	media-libs/tiff"
DEPEND="${RDEPEND}
	test? (
		x11-apps/xhost
		media-fonts/font-misc-misc
		media-fonts/font-cursor-misc )"

src_prepare() {
	local i

	export tcl_cv_cc_visibility_hidden=no

	append-cppflags -DPNG_NO_READ_APNG -DPNG_NO_WRITE_APNG

	epatch "${FILESDIR}"/${P}-unbundle.patch

	rm -rf compat/{libtiff,libjpeg,libpng,zlib}/*.c*

	for i in zlib libpng libjpeg libtiff; do
		pushd ${i} > /dev/null
			einfo "Reconfiguring in ${i} ..."
			eautoreconf
		popd > /dev/null
	done

	eprefixify \
		libjpeg/jpegtclDecls.h \
		libpng/pngtclDecls.h \
		libtiff/tifftclDecls.h \
		zlib/zlibtclDecls.h
}

src_test() {
	Xmake test || die "Xmake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		INSTALL_ROOT="${D}" \
		install || die "emake install failed"
	# Make library links
	for l in "${ED}"/usr/lib*/Img*/*tcl*.so; do
		bl=$(basename $l)
		dosym Img1.4/${bl} /usr/$(get_libdir)/${bl}
	done

	dodoc ChangeLog README Reorganization.Notes.txt changes ANNOUNCE || die
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins demo.tcl || die
		insinto /usr/share/doc/${PF}/html
		doins -r doc/* || die
	fi
}

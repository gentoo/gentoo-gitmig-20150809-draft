# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkimg/tkimg-1.4.20100510-r1.ebuild,v 1.1 2011/10/03 20:04:57 ssuominen Exp $

EAPI="3"

inherit eutils prefix virtualx

DESCRIPTION="Adds a lot of image formats to Tcl/Tk"
HOMEPAGE="http://sourceforge.net/projects/tkimg/"
# src built with:
# svn export https://tkimg.svn.sourceforge.net/svnroot/tkimg/trunk tkimg-1.4.YYYYMMDD
# tar cvfj tkimg-1.4.YYYYMMDD.tar.bz2  tkimg-1.4.YYYYMMDD
SRC_URI="mirror://gentoo/${P}.tar.bz2"

IUSE="doc"
SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"

DEPEND="
	dev-lang/tk
	>=dev-tcltk/tcllib-1.11
	virtual/jpeg
	media-libs/tiff"
RDEPEND="${DEPEND}"

src_prepare() {
	# Use bundled libpng14 temporarily to workaround #378261
	epatch \
		"${FILESDIR}"/${P}-gentoo+use_bundled_libpng14.patch \
		"${FILESDIR}"/${P}-boolean.patch

	eprefixify \
		libjpeg/jpegtclDecls.h \
		libtiff/tifftclDecls.h \
		zlib/zlibtclDecls.h
}

src_test() {
	Xemake test || die
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

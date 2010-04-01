# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkimg/tkimg-1.3.20081202-r1.ebuild,v 1.1 2010/04/01 19:58:54 jlec Exp $

EAPI="3"
inherit eutils prefix

DESCRIPTION="Adds a lot of image formats to Tcl/Tk"
HOMEPAGE="http://sourceforge.net/projects/tkimg/"
# src built with:
# svn export https://tkimg.svn.sourceforge.net/svnroot/tkimg/trunk tkimg-1.3.YYYYMMDD
# tar cvfj tkimg-1.3.YYYYMMDD.tar.bz2  tkimg-1.3.YYYYMMDD
SRC_URI="mirror://gentoo/${P}.tar.bz2"

IUSE="doc"
SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND="dev-lang/tk
	>=dev-tcltk/tcllib-1.11
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-systemlibs.patch
	epatch "${FILESDIR}"/${P}-tests.patch
	epatch "${FILESDIR}"/${P}-prefix.patch
	sed -i \
		-e 's:$(prefix)/man:$(prefix)/share/man:g' \
		Makefile.in  || die
	eprefixify \
		libjpeg/tcl/jpegtclDecls.h \
		libpng/tcl/pngtclDecls.h \
		libtiff/tcl/tifftclDecls.h \
		libz/tcl/zlibtclDecls.h
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

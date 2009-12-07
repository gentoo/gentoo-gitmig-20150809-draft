# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkimg/tkimg-1.3.20081202.ebuild,v 1.7 2009/12/07 19:51:39 bicatali Exp $

EAPI=2
inherit eutils

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
	sed -i \
		-e 's:$(prefix)/man:$(prefix)/share/man:g' \
		Makefile.in  || die
}

src_install() {
	emake \
		DESTDIR="${D}" \
		INSTALL_ROOT="${D}" \
		install || die "emake install failed"
	# Make library links
	for l in "${D}"/usr/lib*/Img*/*tcl*.so; do
		bl=$(basename $l)
		dosym Img1.3/${bl} /usr/$(get_libdir)/${bl}
	done

	dodoc ChangeLog README Reorganization.Notes.txt changes ANNOUNCE || die
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins demo.tcl || die
		insinto /usr/share/doc/${PF}/html
		doins -r doc/* || die
	fi
}

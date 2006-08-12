# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/xgraph/xgraph-12.1-r1.ebuild,v 1.2 2006/08/12 03:08:09 weeve Exp $

DESCRIPTION="X11 Plotting Utility"
HOMEPAGE="http://www.isi.edu/nsnam/xgraph/"
SRC_URI="http://www.isi.edu/nsnam/dist/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos sparc ~x86"
IUSE=""
DEPEND="|| ( ( x11-libs/libSM
		x11-libs/libX11
	)
	virtual/x11 )"

src_install() {
	make DESTDIR="${D}" install || die "Compilation failed."

	dodoc README* INSTALL || die "Installing documentation failed."

	insinto /usr/share/${PN}/examples
	doins examples/* || die "Failed to install example files."

	dodir /usr/share/man/man1
	mv "${D}"/usr/share/man/manm/xgraph.man \
		"${D}"/usr/share/man/man1/xgraph.1 || \
		die "Failed to correct man page location."
	rm -Rf "${D}"/usr/share/man/manm/ || \
		die "Failed to remove bogus manm directory."
}

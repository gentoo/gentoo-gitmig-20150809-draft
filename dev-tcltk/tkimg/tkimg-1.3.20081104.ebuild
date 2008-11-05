# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkimg/tkimg-1.3.20081104.ebuild,v 1.1 2008/11/05 19:54:25 bicatali Exp $

inherit eutils

DESCRIPTION="Adds a lot of image formats to Tcl/Tk"
HOMEPAGE="http://sourceforge.net/projects/tkimg/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

IUSE="doc"
SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"

DEPEND="dev-lang/tk
	media-libs/libpng
	media-libs/tiff"

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

	doman doc/man/*
	dodoc ChangeLog README Reorganization.Notes.txt changes ANNOUNCE || die
	insinto /usr/share/doc/${PF}
	doins -r demo
	use doc && dohtml doc/html
}

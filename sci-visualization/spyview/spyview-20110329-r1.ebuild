# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/spyview/spyview-20110329-r1.ebuild,v 1.2 2011/06/18 09:54:40 hwoarang Exp $

EAPI=4

inherit base flag-o-matic eutils multilib

DESCRIPTION="Interactive plotting program"
HOMEPAGE="http://kavli.nano.tudelft.nl/~gsteele/spyview/"
SRC_URI="http://kavli.nano.tudelft.nl/~gsteele/${PN}/versions/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

COMMON_DEPEND=">=dev-libs/boost-1.40
	media-libs/netpbm
	x11-libs/fltk:1
	app-text/ghostscript-gpl"

DEPEND="${COMMON_DEPEND}
	sys-apps/groff"

RDEPEND="${COMMON_DEPEND}
	sci-visualization/gnuplot"

S=${WORKDIR}/spyview-2011-03-29-10_59

PATCHES=( "${FILESDIR}/${P}-xsection_fn.patch" )

src_prepare() {
	append-cflags $(fltk-config --cflags)
	append-cxxflags $(fltk-config --cxxflags) -I/usr/include/netpbm

	# append-ldflags $(fltk-config --ldflags)
	# this one leads to an insane amount of warnings

	append-ldflags -L$(dirname $(fltk-config --libs))

	base_src_prepare
}

src_configure() {
	econf --datadir=/usr/share/spyview --docdir=/usr/share/doc/${PF}
}

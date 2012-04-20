# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/codecgraph/codecgraph-20120114.ebuild,v 1.2 2012/04/20 20:29:41 floppym Exp $

EAPI=4
PYTHON_DEPEND="2"

inherit base python

DESCRIPTION="Generates a graph based on the ALSA description of an HD Audio codec."
HOMEPAGE="http://helllabs.org/codecgraph/"
SRC_URI="http://helllabs.org/codecgraph/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-gfx/graphviz"
DEPEND="${RDEPEND}
	media-gfx/imagemagick"

PATCHES=( "${FILESDIR}/${PV}-makefile-prefix.diff" )

src_install() {
	make DESTDIR="${D}" install || die
	dodoc codecs.txt README BUGS IDEAS
	python_convert_shebangs -r 2 "${ED}"
}

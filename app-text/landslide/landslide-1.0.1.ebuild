# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/landslide/landslide-1.0.1.ebuild,v 1.1 2011/11/19 08:56:26 naota Exp $

EAPI=3

inherit distutils

DESCRIPTION="Landslide generates a slideshow using the slides that power the html5-slides presentation"
HOMEPAGE="https://github.com/adamzap/landslide"
SRC_URI="https://github.com/adamzap/landslide/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-python/docutils
	dev-python/jinja
	dev-python/markdown
	dev-python/pygments"

src_unpack() {
	unpack ${A}
	mv adamzap-landslide-* ${P} || die
}

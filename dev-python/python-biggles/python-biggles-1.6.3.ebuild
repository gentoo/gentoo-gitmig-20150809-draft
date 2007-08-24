# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-biggles/python-biggles-1.6.3.ebuild,v 1.11 2007/08/24 23:12:49 coldwind Exp $

inherit eutils distutils

DESCRIPTION="A Python module for creating publication-quality 2D scientific plots."
SRC_URI="mirror://sourceforge/biggles/${P}.tar.gz"
HOMEPAGE="http://biggles.sourceforge.net"

DEPEND="~media-libs/plotutils-2.4.1
	dev-python/numeric
	x11-libs/libSM
	x11-libs/libXext"
RDEPEND="${DEPEND}"

IUSE=""
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DOCS="examples/*"

pkg_setup() {
	if ! built_with_use media-libs/plotutils X ; then
		eerror "${P} needs media-libs/plotutils built with"
		eerror "USE=\"X\", please rebuild it with X enabled"
		eerror "and emerge ${P} again."
		die "media-libs/plotutils built without USE=\"X\""
	fi
}

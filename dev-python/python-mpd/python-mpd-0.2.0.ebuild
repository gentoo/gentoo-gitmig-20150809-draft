# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-mpd/python-mpd-0.2.0.ebuild,v 1.5 2008/07/13 09:39:22 angelos Exp $

inherit distutils

DESCRIPTION="Python MPD client library"
HOMEPAGE="http://www.musicpd.org/~jat/python-mpd/"
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="amd64 ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE=""

RDEPEND=">=virtual/python-2.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="CHANGES.txt README.txt TODO.txt doc/commands.txt"

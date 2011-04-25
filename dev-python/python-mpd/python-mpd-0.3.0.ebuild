# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-mpd/python-mpd-0.3.0.ebuild,v 1.7 2011/04/25 14:53:12 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2:2.4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python MPD client library"
HOMEPAGE="http://jatreuman.indefero.net/p/python-mpd/"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.bz2"

LICENSE="LGPL-3"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND=""

PYTHON_MODNAME="mpd.py"
DOCS="CHANGES.txt README.txt doc/commands.txt"

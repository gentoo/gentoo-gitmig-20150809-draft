# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bpython/bpython-0.9.1.ebuild,v 1.1 2009/06/02 21:57:41 grozin Exp $
inherit distutils
DESCRIPTION="Curses interface to python"
HOMEPAGE="http://www.noiseforfree.com/bpython/"
SRC_URI="http://www.noiseforfree.com/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-python/pygments
	dev-python/pyparsing"
RDEPEND="${DEPEND}"

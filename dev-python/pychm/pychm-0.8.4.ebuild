# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychm/pychm-0.8.4.ebuild,v 1.2 2007/07/03 12:01:30 lucass Exp $

inherit distutils

DESCRIPTION="Python bindings for the chmlib library"
HOMEPAGE="http://gnochm.sourceforge.net/pychm.html"
SRC_URI="mirror://sourceforge/gnochm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="app-doc/chmlib"

PYTHON_MODNAME="chm"

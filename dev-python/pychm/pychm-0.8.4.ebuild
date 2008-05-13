# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychm/pychm-0.8.4.ebuild,v 1.6 2008/05/13 07:51:06 pva Exp $

inherit distutils

DESCRIPTION="Python bindings for the chmlib library"
HOMEPAGE="http://gnochm.sourceforge.net/pychm.html"
SRC_URI="mirror://sourceforge/gnochm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-libs/chmlib"

PYTHON_MODNAME="chm"

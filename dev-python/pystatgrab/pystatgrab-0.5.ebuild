# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pystatgrab/pystatgrab-0.5.ebuild,v 1.2 2010/07/23 23:04:44 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION=" pystatgrab is a set of Python bindings for the libstatgrab library."
HOMEPAGE="http://www.i-scream.org/pystatgrab/"
SRC_URI="http://www.mirrorservice.org/sites/ftp.i-scream.org/pub/i-scream/pystatgrab/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

RDEPEND=">=sys-libs/libstatgrab-0.13"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS NEWS"
PYTHON_MODNAME="statgrab.py"

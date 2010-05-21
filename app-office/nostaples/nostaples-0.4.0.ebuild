# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/nostaples/nostaples-0.4.0.ebuild,v 1.2 2010/05/21 19:35:07 arfrever Exp $

EAPI="3"

# ctypes module is available in >=2.5.
PYTHON_DEPEND="2:2.5"

inherit distutils

DESCRIPTION="A PyGTK-based desktop scanning application with an emphasis on low-volume document archival"
HOMEPAGE="http://www.etlafins.com/nostaples"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/pycairo-1.4.0
	>=dev-python/pygobject-2.14.0
	>=dev-python/gconf-python-2.22.0
	>=dev-python/pygtk-2.12.0
	>=dev-python/reportlab-2.1
	>=dev-python/imaging-1.1.6
	>=dev-python/python-gtkmvc-1.2.2
	>=media-gfx/sane-backends-1.0.19-r1"
RDEPEND="${DEPEND}"

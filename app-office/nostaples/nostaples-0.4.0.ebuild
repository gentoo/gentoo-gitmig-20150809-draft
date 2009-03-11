# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/nostaples/nostaples-0.4.0.ebuild,v 1.1 2009/03/11 05:57:00 blackace Exp $

inherit distutils

DESCRIPTION="A PyGTK-based desktop scanning application with an emphasis on low-volume document archival"
HOMEPAGE="http://www.etlafins.com/nostaples"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"

RDEPEND="${DEPEND}
	|| ( >=dev-lang/python-2.5 dev-python/ctypes )
	>=dev-python/pycairo-1.4.0
	>=dev-python/pygobject-2.14.0
	>=dev-python/gconf-python-2.22.0
	>=dev-python/pygtk-2.12.0
	>=dev-python/reportlab-2.1
	>=dev-python/imaging-1.1.6
	>=dev-python/python-gtkmvc-1.2.2
	>=media-gfx/sane-backends-1.0.19-r1"

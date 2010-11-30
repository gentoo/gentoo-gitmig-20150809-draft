# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/skencil/skencil-1.0_alpha784.ebuild,v 1.1 2010/11/30 03:13:56 hanno Exp $

EAPI=2

PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"

inherit distutils

IUSE=""
S="${WORKDIR}/${PN}-1.0alpha"
DESCRIPTION="Interactive X11 vector drawing program"
SRC_URI="http://sk1.googlecode.com/files/${P/_alpha/alpha_rev}.tar.gz"
HOMEPAGE="http://www.skencil.org/"
DEPEND=">=dev-python/imaging-1.1.2-r1
	dev-python/reportlab
	dev-lang/tk
	sys-devel/gettext
	dev-python/pyxml"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

DOCS="README"

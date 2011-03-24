# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kaa-display/kaa-display-0.1.0.ebuild,v 1.6 2011/03/24 09:42:59 tomka Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

DESCRIPTION="Python API providing Low level support for various displays, such as X11 or framebuffer."
HOMEPAGE="http://freevo.sourceforge.net/kaa/"
SRC_URI="mirror://sourceforge/freevo/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-python/kaa-base-0.3.0
	>=dev-python/kaa-imlib2-0.2.0
	>=dev-python/pygame-1.6.0
	>=media-libs/imlib2-1.2.1
	>=x11-libs/libX11-1.0.0"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="kaa/display"

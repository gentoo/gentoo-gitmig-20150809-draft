# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bzrtools/bzrtools-1.3.0.ebuild,v 1.1 2008/03/20 21:39:26 hawking Exp $

NEED_PYTHON=2.4

inherit distutils versionator

DESCRIPTION="bzrtools is a useful collection of utilities for bzr."
HOMEPAGE="http://bazaar.canonical.com/BzrTools"
SRC_URI="http://launchpad.net/bzrtools/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="=dev-util/bzr-$(get_version_component_range 1-2)*"

DOCS="CREDITS NEWS.Shelf TODO.Shelf"

S="${WORKDIR}/${PN}"

PYTHON_MODNAME=bzrlib

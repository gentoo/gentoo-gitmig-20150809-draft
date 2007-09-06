# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bzrtools/bzrtools-0.90.0.ebuild,v 1.1 2007/09/06 09:35:05 hawking Exp $

NEED_PYTHON=2.4

inherit distutils versionator

DESCRIPTION="bzrtools is a useful collection of utilities for bzr."
HOMEPAGE="http://bazaar.canonical.com/BzrTools"
SRC_URI="http://panoramicfeedback.com/opensource/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="=dev-util/bzr-$(get_version_component_range 1-2)*"
RDEPEND="${DEPEND}"

DOCS="CREDITS NEWS NEWS.Shelf README README.Shelf TODO TODO.Shelf"

S="${WORKDIR}/${PN}"

PYTHON_MODNAME=bzrlib

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bzrtools/bzrtools-0.9.1.ebuild,v 1.1 2006/08/24 18:48:26 marienz Exp $

inherit distutils eutils

DESCRIPTION="bzrtools is a useful collection of utilities for bzr."
HOMEPAGE="http://bazaar.canonical.com/BzrTools"
SRC_URI="http://panoramicfeedback.com/opensource/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	=dev-util/bzr-0.9*"

DOCS="CREDITS NEWS NEWS.Shelf README README.Shelf TODO TODO.Shelf"

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/releaseforge/releaseforge-0.9.9.ebuild,v 1.1 2006/03/28 05:01:31 vapier Exp $

inherit distutils

DESCRIPTION="GUI utility for making software releases on SourceForge"
HOMEPAGE="http://releaseforge.sourceforge.net/"
SRC_URI="mirror://sourceforge/releaseforge/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=dev-python/PyQt-3.0.0"

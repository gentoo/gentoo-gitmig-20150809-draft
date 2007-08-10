# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/linkchecker/linkchecker-4.7.ebuild,v 1.2 2007/08/10 13:54:06 armin76 Exp $

inherit distutils

DESCRIPTION="LinkChecker can check HTML documents for broken links."
HOMEPAGE="http://linkchecker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"

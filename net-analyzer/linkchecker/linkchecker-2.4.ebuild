# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/linkchecker/linkchecker-2.4.ebuild,v 1.1 2005/02/09 15:28:54 ka0ttic Exp $

IUSE=""

inherit distutils

LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://linkchecker.sourceforge.net/"
DESCRIPTION="LinkChecker can check HTML documents for broken links."
KEYWORDS="~x86 ~ppc ~amd64"
RESTRICT="nomirror"
SLOT=0

DEPEND=">=dev-lang/python-2.3.3"

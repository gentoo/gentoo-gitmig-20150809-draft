# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/linkchecker/linkchecker-5.0.2.ebuild,v 1.1 2009/06/29 22:54:57 jer Exp $

inherit distutils

MY_P="${P/linkchecker/LinkChecker}"

DESCRIPTION="Check websites for broken links"
HOMEPAGE="http://linkchecker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.5"
RDEPEND="${DEPEND}"

RESTRICT="test"

S="${WORKDIR}/${MY_P}"


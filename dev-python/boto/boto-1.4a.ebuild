# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/boto/boto-1.4a.ebuild,v 1.1 2008/09/20 16:40:16 caleb Exp $

inherit distutils

IUSE=""
DESCRIPTION="Amazon Web Services API"
HOMEPAGE="http://code.google.com/p/boto/"
SRC_URI="http://boto.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-lang/python-2.3"
